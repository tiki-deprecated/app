import 'dart:convert';

import 'package:logging/logging.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_auth_service/model/api_auth_sv_email_interface.dart';
import '../api_auth_service/model/api_auth_sv_provider_interface.dart';
import '../api_company/api_company_service.dart';
import '../api_company/model/api_company_model_local.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import 'model/data_bkg_model_page.dart';

class DataBkgServiceEmail {
  final _log = Logger('DataBkgServiceEmail');
  final ApiAppDataService _apiAppDataService;
  final ApiCompanyService _apiCompanyService;
  final ApiEmailSenderService _apiEmailSenderService;
  final ApiEmailMsgService _apiEmailMsgService;
  final ApiAuthService _apiAuthService;

  DataBkgServiceEmail(
      {required ApiAppDataService apiAppDataService,
      required ApiCompanyService apiCompanyService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiEmailMsgService apiEmailMsgService,
      required ApiAuthService apiAuthService})
      : this._apiAuthService = apiAuthService,
        this._apiCompanyService = apiCompanyService,
        this._apiEmailSenderService = apiEmailSenderService,
        this._apiEmailMsgService = apiEmailMsgService,
        this._apiAppDataService = apiAppDataService;

  Future<void> index(ApiAuthServiceAccountModel account,
      {bool fetchAll = false, bool force = false}) async {
    String providerName = account.provider!;
    ApiAuthServiceProviderInterface? providerService =
        await _apiAuthService.getProvider(account);
    ApiAuthServiceEmailInterface? emailProviderService =
        providerService?.emailProvider;
    if (emailProviderService == null) {
      _log.warning(providerName + ' email Provider Service is null');
    } else {
      _log.fine(providerName +
          ' fetch starting on: ' +
          DateTime.now().toIso8601String());
      String query = await emailProviderService.getQuery();
      await _checkEmailFetchList(account, query: query);
      await emailProviderService.afterFetchList();
      _log.fine(
          'Email fetch completed on: ' + DateTime.now().toIso8601String());
    }
  }

  Future<bool> unsubscribe(ApiAuthServiceAccountModel account,
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
    ApiAuthServiceProviderInterface? providerService =
        _apiAuthService.getProvider(account);
    ApiAuthServiceEmailInterface? emailProviderService =
        providerService?.emailProvider;
    if (emailProviderService != null)
      await _apiAuthService.proxy(
          () => emailProviderService.sendRawMessage(
              account, base64UrlEncode(utf8.encode(email))),
          account);
    return true;
  }

  Future<ApiEmailSenderModel?> _saveSender(ApiEmailSenderModel sender) async {
    if (sender.email != null) {
      ApiCompanyModelLocal? company =
          await _apiCompanyService.upsert(_domainFromEmail(sender.email!));
      if (company != null) {
        sender.company = company;
        ApiEmailSenderModel saved = await _apiEmailSenderService.upsert(sender);
        return saved;
      }
    }
  }

  Future<void> _checkEmailFetchList(ApiAuthServiceAccountModel account,
      {String query = ''}) async {
    String? page;
    ApiAuthServiceProviderInterface? providerService =
        await _apiAuthService.getProvider(account);
    ApiAuthServiceEmailInterface? emailProviderService =
        providerService?.emailProvider;
    if (emailProviderService != null) {
      page = await emailProviderService.getPage();
      await _checkEmailFetchListPage(account, query: query, page: page);
    }
  }

  Future<void> _checkEmailFetchListPage(ApiAuthServiceAccountModel account,
      {String? page, String? query}) async {
    ApiAuthServiceProviderInterface? providerService =
        await _apiAuthService.getProvider(account);
    ApiAuthServiceEmailInterface? emailProviderService =
        providerService?.emailProvider;
    if (emailProviderService != null) {
      DataBkgModelPage<String> res = await emailProviderService
          .emailFetchList(account, query: query, page: page, maxResults: 5);
      if (res.data != null) {
        List known = (await _apiEmailMsgService.getByExtMessageIds(res.data!))
            .map((message) => message.extMessageId!)
            .toList();
        List<String> unknown =
            res.data!.where((message) => !known.contains(message)).toList();
        await _checkEmailFetchMessage(account, unknown);
      }
      await _apiAppDataService.save(ApiAppDataKey.gmailPage, res.next ?? '');
      if (res.next != null)
        return _checkEmailFetchListPage(account, page: res.next, query: query);
    }
  }

  Future<void> _checkEmailFetchMessage(
      ApiAuthServiceAccountModel account, List<String> messages) async {
    ApiAuthServiceProviderInterface? providerService =
        await _apiAuthService.getProvider(account);
    ApiAuthServiceEmailInterface? emailProviderService =
        providerService?.emailProvider;
    Set<String> processed = Set();
    if (emailProviderService == null) return;
    for (String messageId in messages) {
      ApiEmailMsgModel? message =
          await emailProviderService.emailFetchMessage(account, messageId);
      if (message?.extMessageId != null) processed.add(message!.extMessageId!);
      if (message?.sender?.email != null &&
          message?.sender?.unsubscribeMailTo != null) {
        ApiEmailSenderModel? sender =
            await _apiEmailSenderService.getByEmail(message!.sender!.email!);
        if (sender != null) {
          await _saveSender(sender);
          await _apiEmailMsgService.upsert(message);
          _log.fine('Sender upsert: ' + (sender.company?.domain ?? ''));
          // TODO check removed notifyListeners();
        } else {
          Set<ApiEmailMsgModel> senderMessages =
              await _checkEmailNewSender(account, message.sender!.email!);
          Set<String> senderMessageIds =
              senderMessages.map((message) => message.extMessageId!).toSet();
          List<String> newMessages = messages
              .where((message) =>
                  !senderMessageIds.contains(message) &&
                  !processed.contains(message))
              .toList();
          return _checkEmailFetchMessage(account, newMessages);
        }
      }
    }
  }

  Future<Set<ApiEmailMsgModel>> _checkEmailNewSender(
      ApiAuthServiceAccountModel account, String email) async {
    List<String> messageIds = await _checkEmailNewSenderPage(account,
        email: email, messages: List.empty(growable: true));
    Set<ApiEmailMsgModel> messages = Set();
    DateTime first = DateTime.now();
    ApiAuthServiceProviderInterface? providerService =
        await _apiAuthService.getProvider(account);
    ApiAuthServiceEmailInterface? emailProviderService =
        providerService?.emailProvider;
    if (emailProviderService == null) return messages;
    for (String messageId in messageIds) {
      ApiEmailMsgModel? message =
          await emailProviderService.emailFetchMessage(account, messageId);
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
      // TODO check notifyListeners();
    }
    return messages;
  }

  Future<List<String>> _checkEmailNewSenderPage(
      ApiAuthServiceAccountModel account,
      {required String email,
      String? page,
      required List<String> messages}) async {
    ApiAuthServiceEmailInterface emailProviderService = await _apiAuthService
        .getProvider(account) as ApiAuthServiceEmailInterface;
    DataBkgModelPage<String> res = await emailProviderService
        .emailFetchList(account, query: 'from:' + email, page: page);
    if (res.data != null) messages.addAll(res.data!);
    if (res.next != null)
      return _checkEmailNewSenderPage(account,
          email: email, page: res.next, messages: messages);
    else
      return messages;
  }

  String _domainFromEmail(String email) {
    List<String> atSplit = email.split('@');
    List<String> periodSplit = atSplit[atSplit.length - 1].split('.');
    return periodSplit[periodSplit.length - 2] +
        "." +
        periodSplit[periodSplit.length - 1];
  }
}
