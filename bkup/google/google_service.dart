/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

//google api connects
//load and return info cards

import 'package:app/src/slices/google/repository/google_info_repository.dart';
import 'package:app/src/slices/info_carousel_card/model/info_carousel_card_model.dart';
import 'package:app/src/utils/helper_json.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GoogleInfoRepository _googleInfoRepository = GoogleInfoRepository();

  getConnectedUser() async {
    return await _googleSignIn.signInSilently();
  }

  void onChanged(Function(GoogleSignInAccount? account) listener) {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) => listener);
  }

  Future<GoogleSignInAccount?> signIn() async {
    return await _googleSignIn.signIn();
  }

  Future<bool> signOut() async {
    await _googleSignIn.signOut();
    var success = !await _googleSignIn.isSignedIn();
    return success;
  }

  isConnected() {
    return _googleSignIn.isSignedIn();
  }

  Future<List<InfoCarouselCardModel>> getInfoCards() async {
    List<dynamic>? infoJson = await _googleInfoRepository.load();
    return HelperJson.listFromJson(
        infoJson, (s) => InfoCarouselCardModel.fromJson(s));
  }
}
