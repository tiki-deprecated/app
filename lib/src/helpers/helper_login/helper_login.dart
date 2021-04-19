/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login/helper_login_bloc_provider.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc_provider.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_bloc_provider.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

import 'helper_login_view.dart';

class HelperLogin extends StatelessWidget {
  final Widget _loggedIn;
  final Widget _creating;
  final Widget _loggedOut;
  final Widget _pending;
  final String _otp;

  HelperLogin(this._otp, this._loggedIn, this._creating, this._loggedOut,
      this._pending);

  @override
  Widget build(BuildContext context) {
    return HelperLoginBlocProvider(
        RepoSSUserBlocProvider.of(context).bloc,
        RepoBouncerJwtBlocProvider.of(context).bloc,
        RepoSSSecurityKeysBlocProvider.of(context).bloc,
        child:
            HelperLoginView(_otp, _loggedIn, _creating, _loggedOut, _pending));
  }
}
