/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/repo/repo_api_bouncer_jwt/repo_api_bouncer_jwt.dart';
import 'package:app/src/features/repo/repo_api_bouncer_jwt/repo_api_bouncer_jwt_req_refresh.dart';
import 'package:app/src/features/repo/repo_api_bouncer_jwt/repo_api_bouncer_jwt_rsp.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/features/repo/repo_local_ss_token/repo_local_ss_token.dart';
import 'package:app/src/features/repo/repo_local_ss_token/repo_local_ss_token_model.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:app/src/utils/helper/helper_log_out.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class HelperApiAuth {
  final RepoLocalSsCurrent _repoLocalSsCurrent;
  final RepoLocalSsToken _repoLocalSsToken;
  final RepoApiBouncerJwt _repoApiBouncerJwt;

  HelperApiAuth(this._repoLocalSsCurrent, this._repoLocalSsToken,
      this._repoApiBouncerJwt);

  HelperApiAuth.provide(BuildContext context)
      : _repoLocalSsCurrent =
            RepositoryProvider.of<RepoLocalSsCurrent>(context),
        _repoLocalSsToken = RepositoryProvider.of<RepoLocalSsToken>(context),
        _repoApiBouncerJwt = RepositoryProvider.of<RepoApiBouncerJwt>(context);

  Future<HelperApiRsp<T>> proxy<T>(
      Future<HelperApiRsp<T>> Function() request) async {
    HelperApiRsp<T> rsp = await request();
    if (rsp.code == 401) {
      RepoLocalSsCurrentModel current =
          await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
      RepoLocalSsTokenModel token =
          await _repoLocalSsToken.find(current.email!);
      if (token.refresh == null) {
        Sentry.captureMessage("No refresh token. Logging out",
            level: SentryLevel.warning);
        HelperLogOut.provide(ConfigNavigate.key.currentContext!)
            .user(ConfigNavigate.key.currentContext!, current.email!);
      } else {
        HelperApiRsp<RepoApiBouncerJwtRsp> refreshRsp = await _repoApiBouncerJwt
            .refresh(RepoApiBouncerJwtReqRefresh(token.refresh));
        if (refreshRsp.code == 200) {
          RepoApiBouncerJwtRsp jwt = refreshRsp.data;
          _repoLocalSsToken.save(
              current.email!,
              RepoLocalSsTokenModel(
                  bearer: jwt.accessToken,
                  refresh: jwt.refreshToken,
                  expiresIn: jwt.expiresIn));
          rsp = await request();
        }
      }
    }
    return rsp;
  }

  Future<String?> bearer() async {
    RepoLocalSsCurrentModel current =
        await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
    RepoLocalSsTokenModel token = await _repoLocalSsToken.find(current.email!);
    return token.bearer;
  }

  Future<String?> bearerForUser(String email) async {
    RepoLocalSsTokenModel token = await _repoLocalSsToken.find(email);
    return token.bearer;
  }
}
