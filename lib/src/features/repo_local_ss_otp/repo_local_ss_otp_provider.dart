/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'repo_local_ss_otp.dart';

class RepoLocalSsOtpProvider extends InheritedWidget {
  final RepoLocalSsOtp _repo;

  RepoLocalSsOtpProvider(
      {Key key, Widget child, FlutterSecureStorage secureStorage})
      : _repo = RepoLocalSsOtp(secureStorage: secureStorage),
        super(key: key, child: child);

  RepoLocalSsOtp get repo => _repo;

  static RepoLocalSsOtpProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RepoLocalSsOtpProvider>();
  }

  @override
  bool updateShouldNotify(RepoLocalSsOtpProvider oldWidget) {
    return true;
  }
}
