import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as gapis;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../../utils/helper_json.dart';
import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_app_data/model/api_app_data_model.dart';
import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_auth_service/model/api_auth_sv_email_interface.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../data_bkg/model/data_bkg_model_page.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'api_google_service.dart';
import 'repository/api_google_repository_info.dart';

class ApiGoogleServiceEmail extends ApiGoogleService
    implements ApiAuthServiceEmailInterface {
  ApiAppDataService _apiAppDataService;
  var _log = Logger('ApiGoogleServiceEmail');

  ApiGoogleServiceEmail(
      {required ApiAuthServiceAccountModel account,
      required ApiAuthService apiAuthService,
      required ApiAppDataService apiAppDataService})
      : _apiAppDataService = apiAppDataService,
        super(apiAuthService);

  @override
  Future<DataBkgModelPage<String>> emailFetchList(
      ApiAuthServiceAccountModel account,
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
        return emailFetchList(account,
            query: query,
            retries: retries! - 1,
            page: page,
            maxResults: maxResults);
      rethrow;
    }
  }

  @override
  Future<ApiEmailMsgModel?> emailFetchMessage(
      ApiAuthServiceAccountModel account, String messageId,
      {String format = "metadata",
      List<String>? headers,
      int retries = 3}) async {
    try {
      return await _gmailFetchMessage(account, messageId,
          format: format, headers: headers);
    } catch (e) {
      _log.warning(
          "gmailFetchMessage failed, retries: " + retries.toString(), e);
      if (retries > 1)
        return emailFetchMessage(account, messageId,
            format: format, headers: headers, retries: retries - 1);
      rethrow;
    }
  }

  @override
  Future<int?> getLastFetch() async {
    ApiAppDataModel? appDataGmailLastFetch =
        await _apiAppDataService.getByKey(ApiAppDataKey.bkgSvEmailLastFetch);
    return appDataGmailLastFetch != null
        ? int.parse(appDataGmailLastFetch.value)
        : null;
  }

  @override
  Future<String> getPage() async {
    return (await _apiAppDataService.getByKey(ApiAppDataKey.gmailPage))
            ?.value ??
        '';
  }

  @override
  Future<String> getQuery({bool fetchAll = true, bool force = true}) async {
    int? appDataGmailLastFetch = await getLastFetch();
    int? gmailLastFetchEpoch = fetchAll || appDataGmailLastFetch == null
        ? null
        : appDataGmailLastFetch;
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
  Future<bool> sendRawMessage(
      ApiAuthServiceAccountModel account, String getBase64Email) async {
    GmailApi? gmailApi = await _getGmailApi(account);
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

  Future<DataBkgModelPage<String>> _gmailFetch(
      ApiAuthServiceAccountModel account,
      {String? query,
      int? maxResults,
      String? page}) async {
    GmailApi? gmailApi = await _getGmailApi(account);
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

  Future<GmailApi?> _getGmailApi(ApiAuthServiceAccountModel account) async {
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

  Future<ApiEmailMsgModel?> _gmailFetchMessage(
      ApiAuthServiceAccountModel account, String messageId,
      {String format = "metadata", List<String>? headers}) async {
    GmailApi? gmailApi = await _getGmailApi(account);
    if (gmailApi != null) {
      List<String> metadataHeaders = ["From", "To"];
      metadataHeaders.addAll(headers ?? []);
      Message? message = await gmailApi.users.messages
          .get("me", messageId,
              format: format, metadataHeaders: metadataHeaders)
          .timeout(Duration(seconds: 10),
              onTimeout: () =>
                  throw new http.ClientException('_gmailFetch timed out'));
      _log.finest('Fetched message ids: ' + (message.id ?? ''));
      return _convertMessage(message, account.email!);
    }
  }

  ApiEmailMsgModel? _convertMessage(Message message, String email) {
    DateTime? openedDate;
    List<MessagePartHeader>? headers = message.payload?.headers;
    if (headers != null) {
      for (var headerEntry in headers) {
        switch (headerEntry.name!.trim()) {
          case "To":
            String headerEmail = headerEntry.value!.contains("<")
                ? headerEntry.value!
                    .split("<")
                    .toList()[1]
                    .replaceFirst(">", "")
                    .trim()
                : headerEntry.value!;
            if (email.toLowerCase() != headerEmail.trim().toLowerCase())
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
        account: email,
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

  // TODO in the future we'll have account specific infocards
  @override
  Future<List<InfoCarouselCardModel>> getInfoCards(
      ApiAuthServiceAccountModel account) async {
    List<dynamic>? infoJson = await ApiGoogleRepositoryInfo().gmail();
    return HelperJson.listFromJson(
        infoJson, (s) => InfoCarouselCardModel.fromJson(s));
  }
}
