/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_logout/helper_logout_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'helper_auth_proxy_bloc.dart';

class HelperAuthProxyBlocProvider extends InheritedWidget {
  final HelperAuthProxyBloc _bloc;

  HelperAuthProxyBlocProvider(RepoBouncerJwtBloc repoBouncerJwtBloc,
      RepoSSUserBloc repoSSUserBloc, HelperLogoutBloc helperLogoutBloc,
      {Key key, Widget child})
      : _bloc = HelperAuthProxyBloc(
            repoBouncerJwtBloc, repoSSUserBloc, helperLogoutBloc),
        super(key: key, child: child);

  HelperAuthProxyBloc get bloc => _bloc;

  static HelperAuthProxyBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HelperAuthProxyBlocProvider>();
  }

  @override
  bool updateShouldNotify(HelperAuthProxyBlocProvider oldWidget) {
    return false;
  }
}
