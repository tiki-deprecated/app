/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';

import 'repo_api_bouncer_otp.dart';

class RepoApiBouncerOtpProvider extends InheritedWidget {
  final RepoApiBouncerOtp _repo;

  RepoApiBouncerOtpProvider({Key key, Widget child})
      : _repo = RepoApiBouncerOtp(),
        super(key: key, child: child);

  RepoApiBouncerOtp get repo => _repo;

  static RepoApiBouncerOtpProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepoApiBouncerOtpProvider>();
  }

  @override
  bool updateShouldNotify(RepoApiBouncerOtpProvider oldWidget) {
    return true;
  }
}
