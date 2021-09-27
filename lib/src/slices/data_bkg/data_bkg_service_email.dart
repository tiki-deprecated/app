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
import 'data_bkg_interface_email.dart';
import 'data_bkg_interface_provider.dart';
import 'model/data_bkg_model_page.dart';

class DataBkgServiceEmail {
  final _log = Logger('DataBkgServiceEmail');
  final ApiOAuthService _apiAuthService;
  final ApiAppDataService _apiAppDataService;
  final ApiEmailMsgService _apiEmailMsgService;
  final ApiEmailSenderService _apiEmailSenderService;
  final ApiCompanyService _apiCompanyService;
  final Function notifyListeners;

  DataBkgServiceEmail(
      {required ApiOAuthService apiAuthService,
      required ApiAppDataService apiAppDataService,
      required ApiEmailMsgService apiEmailMsgService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiCompanyService apiCompanyService,
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
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit
to: $to
from: me
subject: $subject

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
    DataBkgInterfaceEmail? emailInterface = await _getEmailInterface(account);
    if (emailInterface != null)
      return await emailInterface.send(account, email);
    return false;
  }

  Future<void> index(ApiOAuthModelAccount account) async {
    _log.fine('Email index for ' +
        (account.email ?? '') +
        ' started on: ' +
        DateTime.now().toIso8601String());

    DataBkgInterfaceEmail? interfaceEmail = await _getEmailInterface(account);
    if (interfaceEmail == null || !await _isConnected(account)) return;

    ApiAppDataModel? appDataIndexEpoch =
        await _apiAppDataService.getByKey(ApiAppDataKey.emailIndexEpoch);
    int? indexEpoch =
        appDataIndexEpoch != null ? int.parse(appDataIndexEpoch.value) : null;

    if (indexEpoch == null ||
        DateTime.now()
            .subtract(Duration(days: 1))
            .isAfter(DateTime.fromMillisecondsSinceEpoch(indexEpoch))) {
      await _loopLabels(interfaceEmail, account, indexEpoch: indexEpoch);
      await _apiAppDataService.save(ApiAppDataKey.emailIndexEpoch,
          DateTime.now().millisecondsSinceEpoch.toString());
      _log.fine('Email index for ' +
          (account.email ?? '') +
          ' completed on: ' +
          DateTime.now().toIso8601String());
    }
  }

  Future<void> _loopLabels(
      DataBkgInterfaceEmail interfaceEmail, ApiOAuthModelAccount account,
      {int? indexEpoch}) async {
    _log.fine('Loop Labels for ${account.email}');
    ApiAppDataModel? appDataIndexLabel =
        await _apiAppDataService.getByKey(ApiAppDataKey.emailIndexLabel);
    String activeLabel = appDataIndexLabel?.value ?? interfaceEmail.labels[0];
    for (int i = interfaceEmail.labels.indexOf(activeLabel);
        i < interfaceEmail.labels.length;
        i++) {
      String label = interfaceEmail.labels[i];
      await _pageList(
          interfaceEmail: interfaceEmail,
          account: account,
          label: label,
          indexEpoch: indexEpoch);
      await _apiAppDataService.save(
          ApiAppDataKey.emailIndexLabel,
          (i + 1 == interfaceEmail.labels.length)
              ? interfaceEmail.labels[0]
              : interfaceEmail.labels[i + 1]);
    }
  }

  Future<void> _pageList(
      {required DataBkgInterfaceEmail interfaceEmail,
      required ApiOAuthModelAccount account,
      String? page,
      String? label,
      int? indexEpoch}) async {
    if (page == null) {
      ApiAppDataModel? appDataIndexPage =
          await _apiAppDataService.getByKey(ApiAppDataKey.emailIndexPage);
      page = appDataIndexPage?.value;
    }
    _log.fine('${account.email} List page $page for $label after $indexEpoch');
    DataBkgModelPage<String> res = await _getList(
        account: account,
        interfaceEmail: interfaceEmail,
        label: label,
        afterEpoch: indexEpoch,
        page: page,
        maxResults: 5);
    if (res.data != null) {
      List<String> known =
          (await _apiEmailMsgService.getByExtMessageIds(res.data!))
              .map((message) => message.extMessageId!)
              .toList();
      List<String> unknown =
          res.data!.where((message) => !known.contains(message)).toList();
      _log.fine("${known.length} known messages");
      await _processMessages(interfaceEmail, account, unknown);
      _log.fine("${unknown.length} unknown messages");
    }
    await _apiAppDataService.save(ApiAppDataKey.emailIndexPage, res.next ?? '');
    if (res.next != null)
      return _pageList(
          interfaceEmail: interfaceEmail,
          account: account,
          label: label,
          indexEpoch: indexEpoch,
          page: res.next);
  }

  Future<void> _processMessages(DataBkgInterfaceEmail interfaceEmail,
      ApiOAuthModelAccount account, List<String> messages) async {
    Set<String> processed = Set();
    _log.fine("Processing ${messages.length} messages");
    for (String messageId in messages) {
      ApiEmailMsgModel? message = await _getMessage(
          account: account,
          interfaceEmail: interfaceEmail,
          messageId: messageId);
      if (message?.extMessageId != null) processed.add(message!.extMessageId!);
      if (message?.sender?.email != null &&
          message?.sender?.unsubscribeMailTo != null) {
        ApiEmailSenderModel? sender =
            await _apiEmailSenderService.getByEmail(message!.sender!.email!);
        if (sender != null) {
          _log.fine("Known sender ${sender.name}");
          await _saveSender(sender);
          await _apiEmailMsgService.upsert(message);
          _log.fine('Sender upsert: ' + (sender.company?.domain ?? ''));
          notifyListeners();
        } else {
          _log.fine("New sender ${message.sender!.email}");
          Set<ApiEmailMsgModel> senderMessages = await _indexSender(
              interfaceEmail, account, message.sender!.email!);
          Set<String> senderMessageIds =
              senderMessages.map((message) => message.extMessageId!).toSet();
          List<String> newMessages = messages
              .where((message) =>
                  !senderMessageIds.contains(message) &&
                  !processed.contains(message))
              .toList();
          return _processMessages(interfaceEmail, account, newMessages);
        }
      }
    }
  }

  Future<Set<ApiEmailMsgModel>> _indexSender(
      DataBkgInterfaceEmail interfaceEmail,
      ApiOAuthModelAccount account,
      String email) async {
    _log.fine("Indexing sender $email");
    List<String> messageIds = await _pageSender(
        interfaceEmail: interfaceEmail,
        account: account,
        email: email,
        messages: List.empty(growable: true));
    Set<ApiEmailMsgModel> messages = Set();
    DateTime first = DateTime.now();
    for (String messageId in messageIds) {
      ApiEmailMsgModel? message = await _getMessage(
          account: account,
          interfaceEmail: interfaceEmail,
          messageId: messageId);
      if (message?.sender?.email != null &&
          message?.sender?.unsubscribeMailTo != null) {
        messages.add(message!);
        if (message.receivedDate != null &&
            message.receivedDate!.isBefore(first))
          first = message.receivedDate!;
      }
    }
    ApiEmailSenderModel sender = messages.first.sender!;
    sender.emailSince = first;
    ApiEmailSenderModel? inserted = await _saveSender(sender);
    if (inserted != null) {
      for (ApiEmailMsgModel message in messages) {
        message.sender = inserted;
        await _apiEmailMsgService.upsert(message);
      }
      _log.fine('Sender upsert: ' + (sender.company?.domain ?? ''));
      notifyListeners();
    }
    return messages;
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

  Future<List<String>> _pageSender(
      {required DataBkgInterfaceEmail interfaceEmail,
      required ApiOAuthModelAccount account,
      required String email,
      required List<String> messages,
      String? page}) async {
    _log.fine("Page sender $email");
    DataBkgModelPage<String> res = await _getList(
        account: account,
        interfaceEmail: interfaceEmail,
        from: email,
        maxResults: 500,
        page: page);
    if (res.data != null) messages.addAll(res.data!);
    if (res.next != null)
      return _pageSender(
          interfaceEmail: interfaceEmail,
          account: account,
          email: email,
          page: res.next,
          messages: messages);
    else
      _log.fine("${messages.length} from page sender $email");
    return messages;
  }

  Future<DataBkgModelPage<String>> _getList(
      {required ApiOAuthModelAccount account,
      required DataBkgInterfaceEmail interfaceEmail,
      String? label,
      String? from,
      int? afterEpoch,
      int? maxResults,
      String? page,
      int? retries = 3}) async {
    try {
      return await interfaceEmail.getList(account,
          label: label,
          from: from,
          afterEpoch: afterEpoch,
          maxResults: maxResults,
          page: page);
    } catch (e) {
      _log.warning(
          "getList failed(" +
              (account.provider ?? "") +
              "), retries: " +
              retries.toString(),
          [e, StackTrace.current]);
      if ((retries ?? 0) > 1)
        return _getList(
          account: account,
          interfaceEmail: interfaceEmail,
          label: label,
          from: from,
          afterEpoch: afterEpoch,
          maxResults: maxResults,
          page: page,
          retries: retries! - 1,
        );
      rethrow;
    }
  }

  Future<ApiEmailMsgModel?> _getMessage(
      {required ApiOAuthModelAccount account,
      required DataBkgInterfaceEmail interfaceEmail,
      required String messageId,
      int? retries = 3}) async {
    try {
      return await interfaceEmail.getMessage(account, messageId);
    } catch (e) {
      _log.warning(
          "getMessage failed(" +
              (account.provider ?? "") +
              "), retries: " +
              retries.toString(),
          [e, StackTrace.current]);
      if ((retries ?? 0) > 1)
        return _getMessage(
          account: account,
          interfaceEmail: interfaceEmail,
          messageId: messageId,
          retries: retries! - 1,
        );
      rethrow;
    }
  }

  Future<DataBkgInterfaceEmail?> _getEmailInterface(
      ApiOAuthModelAccount account) async {
    ApiOAuthInterfaceProvider? apiOAuthProvider =
        await _apiAuthService.interfaceProviders[account.provider];
    DataBkgInterfaceProvider? dataBkgProvider =
        apiOAuthProvider as DataBkgInterfaceProvider?;
    return dataBkgProvider?.email;
  }

  Future<bool> _isConnected(ApiOAuthModelAccount account) async {
    ApiOAuthInterfaceProvider? apiOauthInterface =
        await _apiAuthService.interfaceProviders[account.provider];
    return apiOauthInterface != null &&
        await apiOauthInterface.isConnected(account);
  }

  Future<void> logOut() async {
    await _apiEmailSenderService.deleteAll();
    await _apiEmailMsgService.deleteAll();
  }
}
