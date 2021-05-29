// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';

class HelperGoogleAuth {
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: <String>[GmailApi.gmailReadonlyScope]);

  GoogleSignInAccount? currentUser;

  connect() async {
    currentUser = await _googleSignIn.signInSilently() ?? await _handleSignIn();
    print("google sign In " + (currentUser?.email ?? "não autenticado"));
  }

  Future<GoogleSignInAccount?> _handleSignIn() async {
    try {
      currentUser = await _googleSignIn.signIn();
      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        currentUser = account;
      });
      return currentUser;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> handleSignOut() async {
    print(await _googleSignIn.isSignedIn());
    await _googleSignIn.signOut();
    print(await _googleSignIn.isSignedIn());
  }

  isConnected() {
    return _googleSignIn.isSignedIn();
  }
}
