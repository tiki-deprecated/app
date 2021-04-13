/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'helper_logout_bloc.dart';

class HelperLogoutBlocProvider extends InheritedWidget {
  final HelperLogoutBloc _bloc;

  HelperLogoutBlocProvider(RepoSSUserBloc repoSSUserBloc,
      {Key key, Widget child})
      : _bloc = HelperLogoutBloc(repoSSUserBloc),
        super(key: key, child: child);

  HelperLogoutBloc get bloc => _bloc;

  static HelperLogoutBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HelperLogoutBlocProvider>();
  }

  @override
  bool updateShouldNotify(HelperLogoutBlocProvider oldWidget) {
    return false;
  }
}
