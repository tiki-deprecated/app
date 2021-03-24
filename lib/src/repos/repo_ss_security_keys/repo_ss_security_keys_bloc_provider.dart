/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RepoSSSecurityKeysBlocProvider extends InheritedWidget {
  final RepoSSSecurityKeysBloc _bloc;

  RepoSSSecurityKeysBlocProvider(FlutterSecureStorage secureStorage,
      {Key key, Widget child})
      : _bloc = RepoSSSecurityKeysBloc(secureStorage),
        super(key: key, child: child);

  RepoSSSecurityKeysBloc get bloc => _bloc;

  static RepoSSSecurityKeysBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepoSSSecurityKeysBlocProvider>();
  }

  @override
  bool updateShouldNotify(RepoSSSecurityKeysBlocProvider oldWidget) {
    return false;
  }
}
