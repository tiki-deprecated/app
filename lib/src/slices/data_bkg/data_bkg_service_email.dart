import 'dart:convert';

import 'package:app/src/slices/api_app_data/api_app_data_key.dart';
import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
import 'package:app/src/slices/api_app_data/model/api_app_data_model.dart';
import 'package:app/src/slices/api_company/api_company_service.dart';
import 'package:app/src/slices/api_company/model/api_company_model_local.dart';
import 'package:app/src/slices/api_email_sender/api_email_sender_service.dart';
import 'package:app/src/slices/api_email_sender/model/api_email_sender_model.dart';
import 'package:logging/logging.dart';

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import 'data_bkg_sv_email_prov.dart';
import 'model/data_bkg_model_page.dart';

class DataBkgServiceEmail {
  final _log = Logger('ApiEmailClientService');
  final ApiAuthService _apiAuthService;
  final DataBkgSvEmailProvAbstract _emailProviderService;
  final ApiCompanyService _apiCompanyService;
  final ApiEmailSenderService _apiEmailSenderService;
  final ApiAppDataService _apiAppDataService;

  DataBkgServiceEmail(
      this._apiAuthService,
      this._emailProviderService,
      this._apiCompanyService,
      this._apiEmailSenderService,
      this._apiAppDataService);

  Future<DataBkgModelPage<ApiEmailMsgModel>?> emailFetch(
      ApiAuthServiceAccountModel account,
      {String? query,
      int? maxResults,
      String? page}) async {
    DataBkgModelPage<ApiEmailMsgModel>? emailsPage =
        await _apiAuthService.proxy(
            () => _emailProviderService.emailFecthList(
                query: query, maxResults: maxResults, page: page),
            _emailProviderService.account);
    _log.finest(
        'Fetched ' + (emailsPage?.data?.length.toString() ?? '') + ' messages');
    return emailsPage;
  }

  Future<ApiEmailMsgModel?> emailFetchMessage(String messageId,
      {String format = "metadata",
      List<String>? headers,
      int retries = 3}) async {
    try {
      return await _emailProviderService.emailFetchMessage(messageId,
          format: format, headers: headers);
    } catch (e) {
      _log.warning(
          "emailFetchMessage failed, retries: " + retries.toString(), e);
      if (retries > 1)
        return emailFetchMessage(messageId,
            format: format, headers: headers, retries: retries - 1);
      rethrow;
    }
  }

  Future<bool> unsubscribe(String unsubscribeMailTo, String list) async {
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
${_emailProviderService.account.displayName ?? ''}<br />
<br />
*Sent via http://www.mytiki.com. Join the data ownership<br />
revolution today.<br />
</body>
</html>
''';
    await _apiAuthService.proxy(
        () => _emailProviderService
            .sendRawMessage(base64UrlEncode(utf8.encode(email))),
        _emailProviderService.account);
    return true;
  }

  Future<ApiEmailSenderModel?> _saveSender(ApiEmailSenderModel sender) async {
    if (sender.email != null) {
      ApiCompanyModelLocal? company =
          await _apiCompanyService.upsert(domainFromEmail(sender.email!));
      if (company != null) {
        sender.company = company;
        ApiEmailSenderModel saved = await _apiEmailSenderService.upsert(sender);
        return saved;
      }
    }
  }

  Future<void> checkEmail(DataBkgSvEmailProvAbstract emailProvider,
      {bool fetchAll = false, bool force = false}) async {
    _log.fine('Gmail fetch starting on: ' + DateTime.now().toIso8601String());
    if (!(await emailProvider.isConnected())) {
      _log.fine('Gmail fetch aborted. No Google Account.');
      return;
    }
    ApiAppDataModel? appDataGmailLastFetch =
        await _apiAppDataService.getByKey(ApiAppDataKey.gmailLastFetch);
    int? gmailLastFetchEpoch = fetchAll || appDataGmailLastFetch == null
        ? null
        : int.parse(appDataGmailLastFetch.value);
    if (force == true ||
        gmailLastFetchEpoch == null ||
        DateTime.now().subtract(Duration(days: 1)).isAfter(
            DateTime.fromMillisecondsSinceEpoch(gmailLastFetchEpoch))) {
      DateTime run = DateTime.now();
      String activeCategory =
          (await _apiAppDataService.getByKey(ApiAppDataKey.gmailCategory))
                  ?.value ??
              model.gmailCategoryList[0];
      int categoryStartIndex = model.gmailCategoryList.indexOf(activeCategory);
      int totalCats = model.gmailCategoryList.length;
      for (int i = categoryStartIndex; i < totalCats; i++) {
        String category = model.gmailCategoryList[i];
        String query = _gmailBuildQuery(gmailLastFetchEpoch, category);
        await _checkGmailFetchList(query: query);
        int nextCatIndex = model.gmailCategoryList.indexOf(category) + 1;
        String nextCat = nextCatIndex == totalCats
            ? model.gmailCategoryList[0]
            : model.gmailCategoryList[nextCatIndex];
        await _apiAppDataService.save(ApiAppDataKey.gmailCategory, nextCat);
      }
      await _apiAppDataService.save(
          ApiAppDataKey.gmailLastFetch, run.millisecondsSinceEpoch.toString());
      await _apiAppDataService.save(ApiAppDataKey.gmailPage, '');
      _log.fine(
          'Gmail fetch completed on: ' + DateTime.now().toIso8601String());
    }
  }

  Future<void> _checkEmailFetchList({String query = ''}) async {
    String? page;
    ApiAppDataModel? appDataGmailPage =
        await _apiAppDataService.getByKey(ApiAppDataKey.gmailPage);
    page = appDataGmailPage?.value;
    return _checkGmailFetchListPage(query: query, page: page);
  }

  Future<void> _checkEmailFetchListPage({String? page, String? query}) async {
    DataBkgModelPage<String> res = await _apiGoogleService.gmailFetch(
        query: query, page: page, maxResults: 5);
    if (res.data != null) {
      List<String> known =
          (await _apiEmailMsgService.getByExtMessageIds(res.data!))
              .map((message) => message.extMessageId!)
              .toList();
      List<String> unknown =
          res.data!.where((message) => !known.contains(message)).toList();
      await _checkGmailFetchMessage(unknown);
    }
    await _apiAppDataService.save(ApiAppDataKey.gmailPage, res.next ?? '');
    if (res.next != null)
      return _checkGmailFetchListPage(page: res.next, query: query);
  }

  Future<void> _checkEmailFetchMessage(List<String> messages) async {
    Set<String> processed = Set();
    for (String messageId in messages) {
      ApiEmailMsgModel? message = await _apiGoogleService.gmailFetchMessage(
          messageId,
          format: "metadata",
          headers: ["List-unsubscribe"]);
      if (message?.extMessageId != null) processed.add(message!.extMessageId!);
      if (message?.sender?.email != null &&
          message?.sender?.unsubscribeMailTo != null) {
        ApiEmailSenderModel? sender =
            await _apiEmailSenderService.getByEmail(message!.sender!.email!);
        if (sender != null) {
          await _saveSender(sender);
          await _apiEmailMsgService.upsert(message);
          _log.fine('Sender upsert: ' + (sender.company?.domain ?? ''));
          notifyListeners();
        } else {
          Set<ApiEmailMsgModel> senderMessages =
              await _checkGmailNewSender(message.sender!.email!);
          Set<String> senderMessageIds =
              senderMessages.map((message) => message.extMessageId!).toSet();
          List<String> newMessages = messages
              .where((message) =>
                  !senderMessageIds.contains(message) &&
                  !processed.contains(message))
              .toList();
          return _checkGmailFetchMessage(newMessages);
        }
      }
    }
  }

  Future<Set<ApiEmailMsgModel>> _checkEmailNewSender(String email) async {
    List<String> messageIds = await _checkGmailNewSenderPage(
        email: email, messages: List.empty(growable: true));
    Set<ApiEmailMsgModel> messages = Set();
    DateTime first = DateTime.now();
    for (String messageId in messageIds) {
      ApiEmailMsgModel? message = await _apiGoogleService.gmailFetchMessage(
          messageId,
          format: "metadata",
          headers: ["List-unsubscribe"]);
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

  Future<List<String>> _checkEmailNewSenderPage(
      {required String email,
      String? page,
      required List<String> messages}) async {
    DataBkgModelPage<String> res =
        await _apiGoogleService.gmailFetch(query: 'from:' + email, page: page);
    if (res.data != null) messages.addAll(res.data!);
    if (res.next != null)
      return _checkGmailNewSenderPage(
          email: email, page: res.next, messages: messages);
    else
      return messages;
  }

  Future<ApiEmailSenderModel?> _saveSender(ApiEmailSenderModel sender) async {
    if (sender.email != null) {
      ApiCompanyModelLocal? company =
          await _apiCompanyService.upsert(domainFromEmail(sender.email!));
      if (company != null) {
        sender.company = company;
        ApiEmailSenderModel saved = await _apiEmailSenderService.upsert(sender);
        return saved;
      }
    }
  }

  String domainFromEmail(String email) {
    List<String> atSplit = email.split('@');
    List<String> periodSplit = atSplit[atSplit.length - 1].split('.');
    return periodSplit[periodSplit.length - 2] +
        "." +
        periodSplit[periodSplit.length - 1];
  }
}
