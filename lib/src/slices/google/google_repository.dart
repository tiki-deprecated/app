// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleRepository {
  final GoogleSignIn _googleSignIn =
      GoogleSignIn();

  GoogleSignInAccount? currentUser;

  connect() async {
    currentUser = await _handleSignIn();
    return currentUser;
  }

  getConnectedUser() async {
    return await _googleSignIn.signInSilently();
  }

  Future<GoogleSignInAccount?> _handleSignIn() async {
    try {
      currentUser = await _googleSignIn.signIn();
      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        currentUser = account;
      });
      return currentUser;
    } catch (error) {
      return null;
    }
  }

  Future<bool> handleSignOut() async {
    await _googleSignIn.signOut();
    return ! await _googleSignIn.isSignedIn();
  }

  isConnected() {
    return _googleSignIn.isSignedIn();
  }
}
