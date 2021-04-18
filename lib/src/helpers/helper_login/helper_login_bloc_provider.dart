/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login/helper_login_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:flutter/cupertino.dart';

class HelperLoginBlocProvider extends InheritedWidget {
  final HelperLoginBloc _bloc;

  HelperLoginBlocProvider(
      RepoSSUserBloc repoSSUserBloc,
      RepoBouncerJwtBloc repoBouncerJwtBloc,
      RepoSSSecurityKeysBloc repoSSSecurityKeysBloc,
      {Key key,
      Widget child})
      : _bloc = HelperLoginBloc(
            repoSSUserBloc, repoBouncerJwtBloc, repoSSSecurityKeysBloc),
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
