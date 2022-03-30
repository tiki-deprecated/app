/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:logging/logging.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../api_company/api_company_service.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_push/data_push_service.dart';
import 'data_fetch_interface_email.dart';
import 'data_fetch_interface_provider.dart';
import 'model/data_fetch_model_api.dart';
import 'model/data_fetch_model_last.dart';
import 'model/data_fetch_model_part.dart';
import 'repository/data_fetch_repository_last.dart';
import 'repository/data_fetch_repository_part.dart';

class DataFetchServiceEmail {
  final _log = Logger('DataFetchServiceEmail');
  final ApiOAuthService _apiAuthService;
  final ApiEmailMsgService _apiEmailMsgService;
  final ApiEmailSenderService _apiEmailSenderService;
  final ApiCompanyService _apiCompanyService;
  final DataFetchRepositoryPart _repositoryPart;
  final DataFetchRepositoryLast _repositoryLast;

  final Function notifyListeners;

  final Set<int> _processMutex = {};

  DataFetchServiceEmail(
      {required ApiOAuthService apiAuthService,
      required ApiEmailMsgService apiEmailMsgService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiCompanyService apiCompanyService,
      required DataPushService dataPushService,
      required Database database,
      required this.notifyListeners})
      : _apiAuthService = apiAuthService,
        _apiEmailMsgService = apiEmailMsgService,
        _apiEmailSenderService = apiEmailSenderService,
        _apiCompanyService = apiCompanyService,
        _repositoryPart = DataFetchRepositoryPart(database),
        _repositoryLast = DataFetchRepositoryLast(database);

  Future<void> asyncIndex(ApiOAuthModelAccount account) async {
    _log.fine('Async index for ' +
        (account.email ?? '') +
        ' started on: ' +
        DateTime.now().toIso8601String());

    DataFetchInterfaceEmail? interfaceEmail = await _getEmailInterface(account);
    if (interfaceEmail == null) throw 'Invalid email interface';
    if (!await _isConnected(account)) {
      throw 'ApiOauthAccount ${account.provider} not connected.';
    }

    DataFetchModelLast? last = await _repositoryLast.getByAccountIdAndApi(
        account.accountId!, _apiFromProvider(account.provider)!);
    DateTime? since = last?.fetched;

    if (since == null ||
        DateTime.now().subtract(const Duration(days: 1)).isAfter(since)) {
      DateTime fetchStart = DateTime.now();
      await interfaceEmail.fetchInbox(
          account: account,
          since: since,
          onResult: (messages) async {
            _log.fine('fetched ${messages.length} messages');
            List<DataFetchModelPart<ApiEmailMsgModel>> parts = messages
                .map((message) => DataFetchModelPart(
                    extId: message.extMessageId,
                    account: account,
                    api: _apiFromProvider(account.provider),
                    obj: message))
                .toList();
            await _repositoryPart.batchUpsert(parts);
            _log.fine('saved ${messages.length} messages');
            asyncProcess(account);
          },
          onFinish: () async {
            await _repositoryLast.upsert(DataFetchModelLast(
                account: account,
                api: _apiFromProvider(account.provider),
                fetched: fetchStart));
            _log.fine('finished fetching.');
          });
    }
  }

  Future<void> asyncProcess(ApiOAuthModelAccount account,
      {Function(List)? onFinish}) async {
    if (!_processMutex.contains(account.accountId!)) {
      _processMutex.add(account.accountId!);
      _log.fine('Async process for ' +
          (account.email ?? '') +
          ' started on: ' +
          DateTime.now().toIso8601String());
      _asyncProcess(account, onFinish: onFinish);
    }
  }

  Future<void> _asyncProcess(ApiOAuthModelAccount account,
      {Function(List)? onFinish}) async {
    DataFetchInterfaceEmail? interfaceEmail = await _getEmailInterface(account);
    if (interfaceEmail == null) throw 'Invalid email interface';
    if (!await _isConnected(account)) {
      throw 'ApiOauthAccount ${account.provider} not connected.';
    }

    List<DataFetchModelPart<ApiEmailMsgModel>> parts =
        await _repositoryPart.getByAccountAndApi<ApiEmailMsgModel>(
            account.accountId!,
            _apiFromProvider(account.provider)!,
            (json) => ApiEmailMsgModel.fromJson(json),
            max: 100);
    if (parts.isNotEmpty) {
      _log.fine('Got  ${parts.length} parts');
      List<String> ids = parts
          .where((part) => part.obj?.extMessageId != null)
          .map((part) => part.obj!.extMessageId!)
          .toList();
      List<ApiEmailMsgModel> fetched = List.empty(growable: true);
      List<ApiEmailMsgModel> save = List.empty(growable: true);
      await interfaceEmail.fetchMessages(
          account: account,
          messageIds: ids,
          onResult: (message) {
            if (message.toEmail == account.email! &&
                message.sender?.unsubscribeMailTo != null) save.add(message);
            fetched.add(message);
          },
          onFinish: () async {
            _log.fine('Fetched ${fetched.length} messages');
            Map<String, ApiEmailSenderModel> senders = {};
            save
                .where((msg) => msg.sender != null && msg.sender?.email != null)
                .forEach((msg) => senders[msg.sender!.email!] = msg.sender!);
            senders.forEach((email, sender) {
              List<DateTime?> dates = save.map((msg) {
                if (msg.sender?.email == email) return msg.receivedDate;
              }).toList();
              DateTime? since = dates.reduce((min, date) =>
                  min != null && date != null && date.isBefore(min)
                      ? date
                      : min);
              sender.emailSince = since;
              senders[sender.email!] = sender;
            });
            _log.fine('Saving ${senders.length} senders');
            await _apiEmailSenderService.batchUpsert(List.of(senders.values));

            _log.fine('Saving ${save.length} messages');
            await _apiEmailMsgService.batchUpsert(save);

            Set<String> domains = {};
            for (var sender in senders.values) {
              if (sender.company?.domain != null) {
                domains.add(sender.company!.domain!);
              }
            }
            _log.fine('Saving ${domains.length} companies');
            for (var domain in domains) {
              _apiCompanyService.upsert(domain);
            }

            int count = await _repositoryPart.batchDeleteByExtIdsAndAccount(
                fetched.map((msg) => msg.extMessageId!).toList(),
                account.accountId!);
            _log.fine('finished & deleted $count parts');
            if (onFinish != null) {
              onFinish(fetched);
            }
            _asyncProcess(account);
          });
    } else {
      _processMutex.remove(account.accountId!);
    }
  }

  Future<DataFetchInterfaceEmail?> _getEmailInterface(
      ApiOAuthModelAccount account) async {
    ApiOAuthInterfaceProvider? apiOAuthProvider =
        _apiAuthService.interfaceProviders[account.provider];
    DataFetchInterfaceProvider? dataFetchProvider =
        apiOAuthProvider as DataFetchInterfaceProvider?;
    return dataFetchProvider?.email;
  }

  Future<bool> _isConnected(ApiOAuthModelAccount account) async {
    ApiOAuthInterfaceProvider? apiOauthInterface =
        _apiAuthService.interfaceProviders[account.provider];
    return apiOauthInterface != null &&
        await apiOauthInterface.isConnected(account);
  }

  DataFetchModelApi? _apiFromProvider(String? provider) {
    switch (provider) {
      case ApiOAuthService.PROVIDER_GOOGLE:
        return DataFetchModelApi.gmail;
      case ApiOAuthService.PROVIDER_MICROSOFT:
        return DataFetchModelApi.outlook;
      default:
        return null;
    }
  }
}
