/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/info_carousel_card/model/info_carousel_card_model.dart';
import 'package:app/src/utils/helper_json.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';

import 'repository/api_google_repository_info.dart';

class ApiGoogleService {
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: <String>[GmailApi.gmailModifyScope]);
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

  fetchGmail() async {
    GmailApi gmailApi;
    final authHeaders = await googleUser.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);

    List<gmailApi.Message> messagesList = [];
    Future waitForInit;

    gmailApi = gMail.GmailApi(authenticateClient);

    gMail.ListMessagesResponse results =
        await gmailApi.users.messages.list("me");
    for (gMail.Message message in results.messages) {
      gMail.Message messageData =
          await gmailApi.users.messages.get("me", message.id);
      messagesList.add(messageData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("email")),
      body: buildFutureBuilder(),
    );
  }

  FutureBuilder buildFutureBuilder() {
    return FutureBuilder(
        future: waitForInit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            List<Widget> messageTxt = [];
            for (var m in messagesList) {
              messageTxt.add(Text(m.snippet));
            }
            return Column(
              children: messageTxt,
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
