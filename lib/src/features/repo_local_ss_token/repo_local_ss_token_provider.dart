/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/repo_local_ss_token/repo_local_ss_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RepoLocalSsTokenProvider extends InheritedWidget {
  final RepoLocalSsToken _repo;

  RepoLocalSsTokenProvider(
      {Key key, Widget child, FlutterSecureStorage secureStorage})
      : _repo = RepoLocalSsToken(secureStorage: secureStorage),
        super(key: key, child: child);

  RepoLocalSsToken get repo => _repo;

  static RepoLocalSsTokenProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepoLocalSsTokenProvider>();
  }

  @override
  bool updateShouldNotify(RepoLocalSsTokenProvider oldWidget) {
    return true;
  }
}
