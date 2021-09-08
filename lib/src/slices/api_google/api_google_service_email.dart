import 'package:app/src/slices/api_email_sender/model/api_email_sender_model.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as gapis;
import 'package:http/http.dart' as http;

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_app_data/model/api_app_data_model.dart';
import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../data_bkg/data_bkg_sv_email_prov.dart';
import '../data_bkg/model/data_bkg_model_page.dart';
import 'api_google_service.dart';

class ApiGoogleServiceEmail extends ApiGoogleService
    implements DataBkgSvEmailProvInterface {
  ApiAppDataService _apiAppDataService;
  var _log;

  ApiGoogleServiceEmail(
      {required ApiAuthServiceAccountModel account,
      required ApiAuthService apiAuthService,
      required ApiAppDataService apiAppDataService})
      : _apiAppDataService = apiAppDataService,
        super(account, apiAuthService);

  @override
  Future<DataBkgModelPage<String>> emailFetchList(
      {String? query,
      String? page,
      int? retries = 3,
      int? maxResults = 500}) async {
    try {
      return await _gmailFetch(account,
          query: query, maxResults: maxResults, page: page);
    } catch (e) {
      _log.warning("gmailFetch failed, retries: " + retries.toString(), e);
      if ((retries ?? 0) > 1)
        return emailFetchList(
            query: query,
            retries: retries! - 1,
            page: page,
            maxResults: maxResults);
      rethrow;
    }
  }

  Future<DataBkgModelPage<String>> _gmailFetch(
      ApiAuthServiceAccountModel apiAuthServiceAccountModel,
      {String? query,
      int? maxResults,
      String? page}) async {
    GmailApi? gmailApi = await _getGmailApi();
    List<String>? messages;
    ListMessagesResponse? emails = await gmailApi?.users.messages
        .list("me",
            maxResults: maxResults,
            includeSpamTrash: true,
            pageToken: page,
            q: query)
        .timeout(Duration(seconds: 10),
            onTimeout: () =>
                throw new http.ClientException('_gmailFetch timed out'));
    _log.finest(
        'Fetched ' + (emails?.messages?.length.toString() ?? '') + ' messages');
    if (emails != null && emails.messages != null)
      messages = emails.messages!
          .where((message) => message.id != null)
          .map((message) => message.id!)
          .toList();
    return DataBkgModelPage(next: emails?.nextPageToken, data: messages);
  }

  @override
  Future<String> getLastFetch() {
    // TODO: implement getLastFetch
    throw UnimplementedError();
  }

  @override
  Future<String> getPage() {
    // TODO: implement getPage
    throw UnimplementedError();
  }

  @override
  Future<String> getQuery({bool fetchAll = true, bool force = true}) async {
    ApiAppDataModel? appDataGmailLastFetch =
        await _apiAppDataService.getByKey(ApiAppDataKey.gmailLastFetch);
    int? gmailLastFetchEpoch = fetchAll || appDataGmailLastFetch == null
        ? null
        : int.parse(appDataGmailLastFetch.value);
    if (force == true ||
        gmailLastFetchEpoch == null ||
        DateTime.now().subtract(Duration(days: 1)).isAfter(
            DateTime.fromMillisecondsSinceEpoch(gmailLastFetchEpoch))) {
      String activeCategory =
          (await _apiAppDataService.getByKey(ApiAppDataKey.gmailCategory))
                  ?.value ??
              model.gmailCategoryList[0];
      int categoryStartIndex = model.gmailCategoryList.indexOf(activeCategory);
      String category = model.gmailCategoryList[categoryStartIndex];
      String query = _gmailBuildQuery(gmailLastFetchEpoch, category);
      return query;
    }
    return '';
  }

  @override
  Future<void> afterFetchList() async {
    String activeCategory =
        (await _apiAppDataService.getByKey(ApiAppDataKey.gmailCategory))
                ?.value ??
            model.gmailCategoryList[0];
    int totalCats = model.gmailCategoryList.length;
    int nextCatIndex = model.gmailCategoryList.indexOf(activeCategory) + 1;
    String nextCat = nextCatIndex == totalCats
        ? model.gmailCategoryList[0]
        : model.gmailCategoryList[nextCatIndex];
    await _apiAppDataService.save(ApiAppDataKey.gmailCategory, nextCat);
  }

  @override
  Future<bool> sendRawMessage(String getBase64Email) async {
    GmailApi? gmailApi = await _getGmailApi();
    if (gmailApi != null) {
      await gmailApi.users.messages
          .send(Message.fromJson({'raw': getBase64Email}), "me");
      return true;
    }
    return false;
  }

  String domainFromEmail(String email) {
    List<String> atSplit = email.split('@');
    List<String> periodSplit = atSplit[atSplit.length - 1].split('.');
    return periodSplit[periodSplit.length - 2] +
        "." +
        periodSplit[periodSplit.length - 1];
  }

  String _gmailBuildQuery(int? fetchEpochInMilliseconds, String category) {
    StringBuffer queryBuffer = new StringBuffer();
    if (fetchEpochInMilliseconds != null) {
      int secondsSinceEpoch = (fetchEpochInMilliseconds / 1000).floor();
      _gmailAppendQuery(queryBuffer, "after:" + secondsSinceEpoch.toString());
    }
    if (category != 'category:' && category.isNotEmpty) {
      _gmailAppendQuery(queryBuffer, category);
    } else {
      model.gmailCategoryList
          .where((cat) => cat != 'category:')
          .forEach((cat) => _gmailAppendQuery(queryBuffer, 'NOT $cat'));
    }
    return queryBuffer.toString();
  }

  StringBuffer _gmailAppendQuery(StringBuffer queryBuffer, String append) {
    if (queryBuffer.isNotEmpty) {
      queryBuffer.write(" AND ");
    }
    queryBuffer.write(append);
    return queryBuffer;
  }

  Future<GmailApi?> _getGmailApi() async {
    if (account.accessToken != null) {
      String token = account.accessToken!;
      DateTime tokenExp = account.accessTokenExpiration != null
          ? DateTime.fromMillisecondsSinceEpoch(account.accessTokenExpiration!)
              .toUtc()
          : DateTime.now().toUtc().add(const Duration(days: 365));
      gapis.AccessToken accessToken =
          gapis.AccessToken('Bearer', token, tokenExp);
      List<String> scopes = [
        "openid",
        "https://www.googleapis.com/auth/userinfo.profile",
        "https://www.googleapis.com/auth/gmail.readonly",
        "https://www.googleapis.com/auth/gmail.send"
      ];
      gapis.AccessCredentials credentials =
          gapis.AccessCredentials(accessToken, account.refreshToken, scopes);
      gapis.AuthClient authClient =
          gapis.authenticatedClient(http.Client(), credentials);
      return GmailApi(authClient);
    }
    return null;
  }

  @override
  Future<ApiEmailMsgModel?> emailFetchMessage(String messageId,
      {String format = "metadata",
      List<String>? headers,
      int retries = 3}) async {
    try {
      return await _gmailFetchMessage(messageId,
          format: format, headers: headers);
    } catch (e) {
      _log.warning(
          "gmailFetchMessage failed, retries: " + retries.toString(), e);
      if (retries > 1)
        return emailFetchMessage(messageId,
            format: format, headers: headers, retries: retries - 1);
      rethrow;
    }
  }

  Future<ApiEmailMsgModel?> _gmailFetchMessage(String messageId,
      {String format = "metadata", List<String>? headers}) async {
    GmailApi? gmailApi = await _getGmailApi();
    if (gmailApi != null) {
      List<String> metadataHeaders = ["From", "To"];
      metadataHeaders.addAll(headers ?? []);
      Message? message = await gmailApi?.users.messages
          .get("me", messageId,
              format: format, metadataHeaders: metadataHeaders)
          .timeout(Duration(seconds: 10),
              onTimeout: () =>
                  throw new http.ClientException('_gmailFetch timed out'));
      _log.finest('Fetched message ids: ' + (message?.id ?? ''));
      return message != null ? _convertMessage(message) : null;
    }
  }

  ApiEmailMsgModel? _convertMessage(Message message) {
    DateTime? openedDate;
    List<MessagePartHeader>? headers = message.payload?.headers;
    if (headers != null) {
      for (var headerEntry in headers) {
        switch (headerEntry.name!.trim()) {
          case "To":
            String email = headerEntry.value!.contains("<")
                ? headerEntry.value!
                    .split("<")
                    .toList()[1]
                    .replaceFirst(">", "")
                    .trim()
                : headerEntry.value!;
            if (email.toLowerCase() != account.email!.trim().toLowerCase())
              return null;
            break;
        }
      }
    }
    if (message.labelIds != null) {
      message.labelIds!.forEach((label) {
        if (label.contains("CATEGORY_")) {
          if ("PROMOTION" == label.replaceFirst('CATEGORY_', '')) return null;
        }
      });
      openedDate =
          message.labelIds!.contains("UNREAD") && message.internalDate != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  int.parse(message.internalDate!))
              : null;
    }
    return ApiEmailMsgModel(
        extMessageId: message.id,
        receivedDate: message.internalDate != null
            ? DateTime.fromMillisecondsSinceEpoch(
                int.parse(message.internalDate!))
            : null,
        openedDate: openedDate,
        account: account.email,
        sender: _convertSender(message));
  }

  ApiEmailSenderModel _convertSender(Message message) {
    ApiEmailSenderModel sender = ApiEmailSenderModel();
    List<MessagePartHeader>? headers = message.payload?.headers;
    if (headers != null) {
      for (var headerEntry in headers) {
        switch (headerEntry.name!.trim()) {
          case "From":
            var values = headerEntry.value!.split('<');
            if (values.length == 1)
              sender.email = values[0].trim();
            else if (values.length == 2) {
              sender.name = values[0].trim().replaceAll("\"", '');
              sender.email = values[1].trim().replaceAll('>', '');
            }
            break;
          case "List-Unsubscribe":
            String removeCaret =
                headerEntry.value!.replaceAll('<', '').replaceAll(">", '');
            List<String> splitMailTo = removeCaret.split('mailto:');
            if (splitMailTo.length > 1)
              sender.unsubscribeMailTo = splitMailTo[1].split(',')[0];
            break;
        }
      }
    }
    if (message.labelIds != null) {
      message.labelIds!.forEach((label) {
        if (label.contains("CATEGORY_"))
          sender.category = label.replaceFirst('CATEGORY_', '');
      });
    }
    return sender;
  }
}