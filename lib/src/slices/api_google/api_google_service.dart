/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_company/api_company_service.dart';
import 'package:app/src/slices/api_email/api_email_service.dart';
import 'package:app/src/slices/api_sender/api_sender_service.dart';
import 'package:app/src/slices/info_carousel_card/model/info_carousel_card_model.dart';
import 'package:app/src/utils/helper_json.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';

import 'repository/api_google_repository_info.dart';

class ApiGoogleService {
  static final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: [GmailApi.gmailReadonlyScope]);
  final ApiGoogleRepositoryInfo _googleInfoRepository =
  ApiGoogleRepositoryInfo();

  Future<GoogleSignInAccount?> getConnectedUser() async {
    return await _googleSignIn.signInSilently();
  }

  Future<GoogleSignInAccount?> signIn() async {
    return await _googleSignIn.signIn();
  }

  Future<bool> signOut() async {
    await _googleSignIn.signOut();
    var success = !await _googleSignIn.isSignedIn();
    return success;
  }

  Future<bool> isConnected() async {
    return await _googleSignIn.isSignedIn();
  }

  Future<List<InfoCarouselCardModel>> getInfoCards() async {
    List<dynamic>? infoJson = await _googleInfoRepository.load();
    return HelperJson.listFromJson(
        infoJson, (s) => InfoCarouselCardModel.fromJson(s));
  }

  Future<GmailApi?> getGmailApi() async {
    var authClient = await _googleSignIn.authenticatedClient();
    if (authClient != null) {
      return GmailApi(authClient);
    }
    return null;
  }

  void fetchGmailMessagesMetadata() async {
    var gmailApi = await getGmailApi();
    var emailList = await gmailApi?.users.messages.list("me");
    for (var messageMeta in emailList!.messages!) {
      await fetchAndProcessGmailMessage(messageMeta);
    }
  }

  Future<void> processEmailListMessage(Message message) async {
    var senderData = getSenderData(message);
    var messageExtId = message.id;
    var messageReceivedDate = message.internalDate;
    var messageOpenedDate =
        message.labelIds!.contains("OPENED") ? messageReceivedDate : null;
    var account = _googleSignIn.currentUser!.email;
    var companyId = ApiCompanyService().createOrUpdate(senderData);
    senderData['company_id'] = companyId;
    var senderId = ApiSenderService().createOrUpdate(senderData);
    ApiEmailService().create({
      'sender_id': senderId,
      'message_ext_id': messageExtId,
      'message_received_date': messageReceivedDate,
      'message_opened_date': messageOpenedDate,
      'account': account,
    });
  }

  Future<void> fetchAndProcessGmailMessage(Message messageMeta) async {
    var isListMessage = false;
    var gmailApi = await getGmailApi();
    var message = await gmailApi?.users.messages.get("me", messageMeta.id!,
        format: "metadata", metadataHeaders: ["List-unsubscribe", "From"]);
    var headers = message?.payload?.headers;
    if (headers != null) {
      for (var headerEntry in headers) {
        switch (headerEntry.name!.trim()) {
          case "List-Unsubscribe":
            isListMessage = true;
            break;
        }
      }
    }
    if (isListMessage) processEmailListMessage(message!);
  }

  getSenderData(Message message) {
    var senderName;
    var senderEmail;
    var senderCategory;
    var unsubscribeMailTo;
    var headers = message.payload?.headers;
    if (headers != null) {
      for (var headerEntry in headers) {
        switch (headerEntry.name!.trim()) {
          case "From":
            var values = headerEntry.value!.split('<');
            if (values.length < 2) print(values);
            senderName = values[0].trim();
            senderEmail = values[1].trim().replaceFirst('>', '');
            break;
          case "List-Unsubscribe":
            unsubscribeMailTo = headerEntry.value!;
            break;
        }
      }
    }
    message.labelIds!.forEach((label) {
      if (label.contains("CATEGORY")) senderCategory = label;
    });
    return {
      'senderName': senderName,
      'senderEmail': senderEmail,
      'senderCategory': senderCategory,
      'unsubscribeMailTo': unsubscribeMailTo,
    };
  }
}
