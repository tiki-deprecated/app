/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login/helper_login_bloc_provider.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc_provider.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class HelperLogin extends StatelessWidget {
  final Widget _child;

  HelperLogin({Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return HelperLoginBlocProvider(RepoSSUserBlocProvider.of(context).bloc,
        RepoBouncerJwtBlocProvider.of(context).bloc,
        child: _child);
  }
}
