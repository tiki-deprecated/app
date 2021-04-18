/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_logout/helper_logout_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_req_refresh.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_rsp.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class HelperAuthProxyBloc {
  final RepoBouncerJwtBloc _repoBouncerJwtBloc;
  final RepoSSUserBloc _repoSSUserBloc;
  final HelperLogoutBloc _helperLogoutBloc;

  static const String errorMsg =
      "Attempt to access a secure endpoint with a non-existent or a not logged-in user";

  HelperAuthProxyBloc(
      this._repoBouncerJwtBloc, this._repoSSUserBloc, this._helperLogoutBloc);

  Future<UtilityAPIRsp<T>> execute<T>(
      Future<UtilityAPIRsp<T>> Function() request) async {
    UtilityAPIRsp<T> rsp = await request();
    if (rsp.code == 401) {
      RepoSSUserModel user = await _repoSSUserBloc.find();
      if (user == null || user.loggedIn == false || user.refresh == null) {
        Sentry.captureMessage(errorMsg, level: SentryLevel.warning);
        await _repoSSUserBloc.setLoggedIn(false);
        _helperLogoutBloc.logoutWithException(errorMsg);
      } else {
        UtilityAPIRsp<RepoBouncerJwtModelRsp> refreshRsp =
            await _repoBouncerJwtBloc
                .refresh(RepoBouncerJwtModelReqRefresh(user.refresh));

        if (refreshRsp.code == 200) {
          RepoBouncerJwtModelRsp jwt = refreshRsp.data;
          _repoSSUserBloc.setTokens(jwt.accessToken, jwt.refreshToken);
          rsp = await request();
        }
      }
    }
    return rsp;
  }
}
