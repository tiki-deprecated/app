/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:logging/logging.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../api_app_data/api_app_data_service.dart';
import '../api_company/api_company_service.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_push/data_push_convert.dart';
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

  Set<int> _processMutex = Set();

  DataFetchServiceEmail(
      {required ApiOAuthService apiAuthService,
      required ApiAppDataService apiAppDataService,
      required ApiEmailMsgService apiEmailMsgService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiCompanyService apiCompanyService,
      required DataPushService dataPushService,
      required Database database,
      required this.notifyListeners})
      : this._apiAuthService = apiAuthService,
        this._apiEmailMsgService = apiEmailMsgService,
        this._apiEmailSenderService = apiEmailSenderService,
        this._apiCompanyService = apiCompanyService,
        this._repositoryPart = DataFetchRepositoryPart(database),
        this._repositoryLast = DataFetchRepositoryLast(database);

  //TODO this doesnt belong here
  Future<bool> unsubscribe(ApiOAuthModelAccount account,
      String unsubscribeMailTo, String list) async {
    DataFetchInterfaceEmail? interfaceEmail = await _getEmailInterface(account);
    if (interfaceEmail == null) throw 'Invalid email interface';
    if (!await _isConnected(account))
      throw 'ApiOauthAccount ${account.provider} not connected.';

    Uri uri = Uri.parse(unsubscribeMailTo);
    String to = uri.path;
    String subject = uri.queryParameters['subject'] ?? "Unsubscribe from $list";
    String body = '''
<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN” “https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>
<html xmlns=“https://www.w3.org/1999/xhtml”>
<head>
<title>Test Email Sample</title>
<meta http–equiv=“Content-Type” content=“text/html; charset=UTF-8” />
<meta http–equiv=“X-UA-Compatible” content=“IE=edge” />
<meta name=“viewport” content=“width=device-width, initial-scale=1.0 “ />
</head>
<body class=“em_body” style=“margin:0px; padding:0px;”> 
Hello,<br /><br />
I'd like to stop receiving emails from this email list.<br /><br />
Thanks,<br /><br />
${account.displayName ?? ''}<br />
<br />
* Sent via https://mytiki.com. Join the data ownership revolution. *<br />
</body>
</html>
''';
    bool success = false;
    await interfaceEmail.send(
        account: account,
        to: to,
        body: body,
        subject: subject,
        onResult: (res) => success = res);
    return success;
  }

  Future<void> asyncIndex(ApiOAuthModelAccount account) async {
    _log.fine('Async index for ' +
        (account.email ?? '') +
        ' started on: ' +
        DateTime.now().toIso8601String());

    DataFetchInterfaceEmail? interfaceEmail = await _getEmailInterface(account);
    if (interfaceEmail == null) throw 'Invalid email interface';
    if (!await _isConnected(account))
      throw 'ApiOauthAccount ${account.provider} not connected.';

    DataFetchModelLast? last = await _repositoryLast.getByAccountIdAndApi(
        account.accountId!, _apiFromProvider(account.provider)!);
    DateTime? since = last?.fetched;

    if (since == null ||
        DateTime.now().subtract(Duration(days: 1)).isAfter(since)) {
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

  Future<void> asyncProcess(ApiOAuthModelAccount account) async {
    if (!_processMutex.contains(account.accountId!)) {
      _processMutex.add(account.accountId!);
      _log.fine('Async process for ' +
          (account.email ?? '') +
          ' started on: ' +
          DateTime.now().toIso8601String());
      _asyncProcess(account);
    }
  }

  Future<void> _asyncProcess(ApiOAuthModelAccount account) async {
    DataFetchInterfaceEmail? interfaceEmail = await _getEmailInterface(account);
    if (interfaceEmail == null) throw 'Invalid email interface';
    if (!await _isConnected(account))
      throw 'ApiOauthAccount ${account.provider} not connected.';

    List<DataFetchModelPart<ApiEmailMsgModel>> parts =
        await _repositoryPart.getByAccountAndApi<ApiEmailMsgModel>(
            account.accountId!,
            _apiFromProvider(account.provider)!,
            (json) => ApiEmailMsgModel.fromJson(json),
            max: 100);
    if (parts.length > 0) {
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
            Map<String, ApiEmailSenderModel> senders = Map();
            save
                .where((msg) => msg.sender != null && msg.sender?.email != null)
                .forEach((msg) => senders[msg.sender!.email!] = msg.sender!);

            _log.fine('Saving ${senders.length} senders');
            await _apiEmailSenderService.batchUpsert(List.of(senders.values));

            _log.fine('Saving ${save.length} messages');
            await _apiEmailMsgService.batchUpsert(save);

            Set<String> domains = Set();
            senders.values.forEach((sender) {
              if (sender.company?.domain != null)
                domains.add(sender.company!.domain!);
            });
            _log.fine('Saving ${domains.length} companies');
            domains.forEach((domain) => _apiCompanyService.upsert(domain));

            int count = await _repositoryPart.batchDeleteByExtIdsAndAccount(
                fetched.map((msg) => msg.extMessageId!).toList(),
                account.accountId!);
            _log.fine('finished & deleted $count parts');
            _asyncProcess(account);
          });
    } else
      _processMutex.remove(account.accountId!);
  }

  Future<DataFetchInterfaceEmail?> _getEmailInterface(
      ApiOAuthModelAccount account) async {
    ApiOAuthInterfaceProvider? apiOAuthProvider =
        await _apiAuthService.interfaceProviders[account.provider];
    DataFetchInterfaceProvider? DataFetchProvider =
        apiOAuthProvider as DataFetchInterfaceProvider?;
    return DataFetchProvider?.email;
  }

  Future<bool> _isConnected(ApiOAuthModelAccount account) async {
    ApiOAuthInterfaceProvider? apiOauthInterface =
        await _apiAuthService.interfaceProviders[account.provider];
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
        break;
    }
  }
}
