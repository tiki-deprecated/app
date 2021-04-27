/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/repo_local_ss_keys/repo_local_ss_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RepoLocalSsKeysProvider extends InheritedWidget {
  final RepoLocalSsKeys _repo;

  RepoLocalSsKeysProvider(
      {Key key, Widget child, FlutterSecureStorage secureStorage})
      : _repo = RepoLocalSsKeys(secureStorage: secureStorage),
        super(key: key, child: child);

  RepoLocalSsKeys get repo => _repo;

  static RepoLocalSsKeysProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepoLocalSsKeysProvider>();
  }

  @override
  bool updateShouldNotify(RepoLocalSsKeysProvider oldWidget) {
    return true;
  }
}
