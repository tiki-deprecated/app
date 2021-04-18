/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_logout/helper_logout_bloc_provider.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc_provider.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

import 'helper_auth_proxy_bloc_provider.dart';

class HelperAuthProxy extends StatelessWidget {
  final Widget _child;

  HelperAuthProxy({Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return HelperAuthProxyBlocProvider(
        RepoBouncerJwtBlocProvider.of(context).bloc,
        RepoSSUserBlocProvider.of(context).bloc,
        HelperLogoutBlocProvider.of(context).bloc,
        child: _child);
  }
}
