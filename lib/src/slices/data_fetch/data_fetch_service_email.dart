/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:logging/logging.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_app_data/model/api_app_data_model.dart';
import '../api_company/api_company_service.dart';
import '../api_company/model/api_company_model_local.dart';
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
import 'model/data_fetch_model_page.dart';

class DataFetchServiceEmail {
  final _log = Logger('DataFetchServiceEmail');
  final ApiOAuthService _apiAuthService;
  final ApiAppDataService _apiAppDataService;
  final ApiEmailMsgService _apiEmailMsgService;
  final ApiEmailSenderService _apiEmailSenderService;
  final ApiCompanyService _apiCompanyService;
  final Function notifyListeners;

  DataFetchServiceEmail(
      {required ApiOAuthService apiAuthService,
      required ApiAppDataService apiAppDataService,
      required ApiEmailMsgService apiEmailMsgService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiCompanyService apiCompanyService,
      required DataPushService dataPushService,
      required this.notifyListeners})
      : this._apiAuthService = apiAuthService,
        this._apiAppDataService = apiAppDataService,
        this._apiEmailMsgService = apiEmailMsgService,
        this._apiEmailSenderService = apiEmailSenderService,
        this._apiCompanyService = apiCompanyService;

  Future<bool> unsubscribe(ApiOAuthModelAccount account,
      String unsubscribeMailTo, String list) async {
    Uri uri = Uri.parse(unsubscribeMailTo);
    String to = uri.path;
    String subject = uri.queryParameters['subject'] ?? "Unsubscribe from $list";
    String email = '''
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
*Sent via http://www.mytiki.com. Join the data ownership<br />
revolution today.<br />
</body>
</html>
''';
    DataFetchInterfaceEmail? emailInterface = await _getEmailInterface(account);
    if (emailInterface != null)
      return await emailInterface.send(account, email, to, subject);
    return false;
  }

  Future<void> asyncIndex(ApiOAuthModelAccount account) async {
    _log.fine('Async index for ' +
        (account.email ?? '') +
        ' started on: ' +
        DateTime.now().toIso8601String());

    DataFetchInterfaceEmail? interfaceEmail = await _getEmailInterface(account);
    if (interfaceEmail == null || !await _isConnected(account)) return;

    DateTime? afterEpoch = await _getLastFetchDatetime(account);

    if (afterEpoch == null ||
        DateTime.now().subtract(Duration(days: 1)).isAfter(afterEpoch)) {
      interfaceEmail.fetchInbox(account,
          since: afterEpoch,
          onResult: _processFetchedData,
          onFinish: _endFetchMessageIds);
    }
  }

  Future<void> fetchMessages(ApiOAuthModelAccount account,
      {bool newAccount = false}) async {
    _log.fine('Fetch messages for ' +
        (account.email ?? '') +
        ' started on: ' +
        DateTime.now().toIso8601String());

    DataFetchInterfaceEmail? interfaceEmail = await _getEmailInterface(account);
    if (interfaceEmail == null || !await _isConnected(account)) return;

    List<ApiEmailMsgModel> messages =
        await _apiEmailMsgService.getUnfetchedMessages();
    interfaceEmail.fetchMessages(account,
        messages: messages,
        onResult: _saveMessageData,
        onFinish: _endFetchMessages);
  }

  Future<void> deleteApiAppData(ApiOAuthModelAccount account) async {
    List<ApiAppDataKey> keysToDelete = [
      ApiAppDataKey.emailIndexLabel,
      ApiAppDataKey.emailIndexEpoch,
      ApiAppDataKey.emailIndexPage,
    ];
    keysToDelete.forEach((key) async {
      await _apiAppDataService.delete(key);
    });
  }

  Future<void> _saveMessageIds(List<ApiEmailMsgModel> messages) async {
    _log.fine('Saving ' + messages.length.toString() + " message ids");
    _apiEmailMsgService.saveList(messages);
  }

  Future<void> _saveMessageData(ApiEmailMsgModel message) async {
    if (message.sender?.email == null ||
        message.sender?.unsubscribeMailTo == null) {
      _apiEmailMsgService.delete(message);
      return;
    }
    ApiEmailSenderModel sender =
        (await _apiEmailSenderService.getByEmail(message.sender!.email!)) ??
            message.sender!;
    message.sender = await _saveSender(sender);
    await _apiEmailMsgService.upsert(message);
    //await _dataPushService.write(DataPushConvert.message(message));
    notifyListeners();
  }

  Future<void> _endFetchMessages(ApiOAuthModelAccount account) async {
    await _apiAppDataService.save(ApiAppDataKey.emailIndexEpoch,
        DateTime.now().millisecondsSinceEpoch.toString());
    _log.fine('Fetch message for ' +
        (account.email ?? '') +
        ' completed on: ' +
        DateTime.now().toIso8601String());
  }

  Future<void> _endFetchMessageIds(ApiOAuthModelAccount account) async {
    await _apiAppDataService.save(ApiAppDataKey.emailIndexEpoch,
        DateTime.now().millisecondsSinceEpoch.toString());
    _log.fine('Email async index for ' +
        (account.email ?? '') +
        ' completed on: ' +
        DateTime.now().toIso8601String());
    fetchMessages(account);
  }

  Future<ApiEmailSenderModel?> _saveSender(ApiEmailSenderModel sender) async {
    if (sender.email != null) {
      _log.fine("Saving sender: ${sender.name}.");
      List<String> atSplit = sender.email!.split('@');
      List<String> periodSplit = atSplit[atSplit.length - 1].split('.');
      String domain = periodSplit[periodSplit.length - 2] +
          "." +
          periodSplit[periodSplit.length - 1];
      ApiCompanyModelLocal? company = await _apiCompanyService.upsert(domain);
      if (company != null) {
        sender.company = company;
        ApiEmailSenderModel saved = await _apiEmailSenderService.upsert(sender);
        return saved;
      }
    }
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

  Future<DateTime?> _getLastFetchDatetime(ApiOAuthModelAccount account) async {
    ApiAppDataModel? appDataIndexEpoch =
        await _apiAppDataService.getByKey(ApiAppDataKey.emailIndexEpoch);
    return appDataIndexEpoch == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            int.parse(appDataIndexEpoch.value));
  }

  Future<void> _processFetchedData(DataFetchModelPage fetchedPage) async {
    String? nextPage = fetchedPage.next;
    if(nextPage != null) {
      ApiAppDataModel? appDataIndexPage =
        await _apiAppDataService.getByKey(ApiAppDataKey.emailIndexPage);
      String? savedPage = appDataIndexPage?.value;
      if (savedPage != null && int.parse(nextPage) > int.parse(savedPage)) {
        await _apiAppDataService.save(ApiAppDataKey.emailIndexPage, nextPage);
      }
    }
    if(fetchedPage.data != null && fetchedPage.data!.isNotEmpty)
      _saveMessageIds(fetchedPage.data!);
  }
}
