/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/app.dart';
import 'package:app/src/platform/platform_page_route.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_req_refresh.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_rsp.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/screens/screen_login.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';

class HelperAuthProxyBloc {
  final RepoBouncerJwtBloc _repoBouncerJwtBloc;
  final RepoSSUserBloc _repoSSUserBloc;

  HelperAuthProxyBloc(this._repoBouncerJwtBloc, this._repoSSUserBloc);

  Future<UtilityAPIRsp<T>> execute<T>(
      Future<UtilityAPIRsp<T>> Function() request) async {
    UtilityAPIRsp<T> rsp = await request();
    if (rsp.code == 401) {
      RepoSSUserModel user = await _repoSSUserBloc.find();
      if (user == null || user.loggedIn == false || user.refresh == null) {
        //TODO add a logout helper bloc.
        await _repoSSUserBloc.setLoggedIn(false);
        navigatorKey.currentState
            .pushAndRemoveUntil(platformPageRoute(ScreenLogin()), (_) => false);
      }else {
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
