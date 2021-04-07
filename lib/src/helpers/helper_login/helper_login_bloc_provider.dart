/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login/helper_login_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:flutter/cupertino.dart';

class HelperLoginBlocProvider extends InheritedWidget {
  final HelperLoginBloc _bloc;

  HelperLoginBlocProvider(
      RepoSSUserBloc repoSSUserBloc, RepoBouncerJwtBloc repoBouncerJwtBloc,
      {Key key, Widget child})
      : _bloc = HelperLoginBloc(repoSSUserBloc, repoBouncerJwtBloc),
        super(key: key, child: child);

  HelperLoginBloc get bloc => _bloc;

  static HelperLoginBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HelperLoginBlocProvider>();
  }

  @override
  bool updateShouldNotify(HelperLoginBlocProvider oldWidget) {
    return false;
  }
}
