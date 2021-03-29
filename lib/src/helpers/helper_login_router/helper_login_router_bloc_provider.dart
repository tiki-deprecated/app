/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login_router/helper_login_router_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:flutter/cupertino.dart';

class HelperLoginRouterBlocProvider extends InheritedWidget {
  final HelperLoginRouterBloc _bloc;

  HelperLoginRouterBlocProvider(
      RepoSSUserBloc repoSSUserBloc, RepoBouncerJwtBloc repoBouncerJwtBloc,
      {Key key, Widget child})
      : _bloc = HelperLoginRouterBloc(repoSSUserBloc, repoBouncerJwtBloc),
        super(key: key, child: child);

  HelperLoginRouterBloc get bloc => _bloc;

  static HelperLoginRouterBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HelperLoginRouterBlocProvider>();
  }

  @override
  bool updateShouldNotify(HelperLoginRouterBlocProvider oldWidget) {
    return false;
  }
}
