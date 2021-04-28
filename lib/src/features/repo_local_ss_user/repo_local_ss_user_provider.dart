/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'repo_local_ss_user.dart';

class RepoLocalSsUserProvider extends InheritedWidget {
  final RepoLocalSsUser _repo;

  RepoLocalSsUserProvider(
      {Key key, Widget child, FlutterSecureStorage secureStorage})
      : _repo = RepoLocalSsUser(secureStorage: secureStorage),
        super(key: key, child: child);

  RepoLocalSsUser get repo => _repo;

  static RepoLocalSsUserProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepoLocalSsUserProvider>();
  }

  @override
  bool updateShouldNotify(RepoLocalSsUserProvider oldWidget) {
    return true;
  }
}
