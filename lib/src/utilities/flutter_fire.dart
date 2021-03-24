/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:developer';

import 'package:app/src/utilities/relative_size.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class FlutterFire extends StatelessWidget {
  static final String errorMsg =
      "Failed to initialize Firebase. Carelessly proceeding";
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Widget _splashScreen;
  final Widget _loginDetector;

  FlutterFire(this._splashScreen, this._loginDetector);

  @override
  Widget build(BuildContext context) {
    RelativeSize().init(context);
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log(errorMsg, error: snapshot.error);
          return _loginDetector;
        }
        if (snapshot.connectionState == ConnectionState.done)
          return _loginDetector;
        return _splashScreen;
      },
    );
  }
}
