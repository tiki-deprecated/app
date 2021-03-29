/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RepoSSUserBlocProvider extends InheritedWidget {
  final RepoSSUserBloc _bloc;

  RepoSSUserBlocProvider(FlutterSecureStorage secureStorage,
      {Key key, Widget child})
      : _bloc = RepoSSUserBloc(secureStorage),
        super(key: key, child: child);

  RepoSSUserBloc get bloc => _bloc;

  static RepoSSUserBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RepoSSUserBlocProvider>();
  }

  @override
  bool updateShouldNotify(RepoSSUserBlocProvider oldWidget) {
    return false;
  }
}
