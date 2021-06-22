/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repositories/api/repo_api_bouncer_jwt/repo_api_bouncer_jwt.dart';
import 'package:app/src/repositories/api/repo_api_bouncer_jwt/repo_api_bouncer_jwt_req_refresh.dart';
import 'package:app/src/repositories/api/repo_api_bouncer_jwt/repo_api_bouncer_jwt_rsp.dart';
import 'package:app/src/repositories/api/helper_api_rsp.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_current.dart';
import 'package:app/src/repositories/secure_storage/secure_storage_repository_token.dart';
import 'package:app/src/slices/auth/repository/helper_log_out.dart';
import 'package:app/src/slices/app/model/app_model_current.dart';
import 'package:app/src/slices/login_screen/model/login_screen_model_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class HelperApiAuth {
  final SecureStorageRepositoryCurrent _repoLocalSsCurrent;
  final SecureStorageRepositoryToken _repoLocalSsToken;
  final RepoApiBouncerJwt _repoApiBouncerJwt;

  HelperApiAuth(this._repoLocalSsCurrent, this._repoLocalSsToken,
      this._repoApiBouncerJwt);

  HelperApiAuth.provide(BuildContext context)
      : _repoLocalSsCurrent =
            RepositoryProvider.of<SecureStorageRepositoryCurrent>(context),
        _repoLocalSsToken = RepositoryProvider.of<SecureStorageRepositoryToken>(context),
        _repoApiBouncerJwt = RepositoryProvider.of<RepoApiBouncerJwt>(context);

  Future<HelperApiRsp<T>> proxy<T>(
      Future<HelperApiRsp<T>> Function() request) async {
    HelperApiRsp<T> rsp = await request();
    if (rsp.code == 401) {
      AppModelCurrent current =
          await _repoLocalSsCurrent.find(SecureStorageRepositoryCurrent.key);
      LoginScreenModelToken token =
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
              LoginScreenModelToken(
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
    AppModelCurrent current =
        await _repoLocalSsCurrent.find(SecureStorageRepositoryCurrent.key);
    LoginScreenModelToken token = await _repoLocalSsToken.find(current.email!);
    return token.bearer;
  }

  Future<String?> bearerForUser(String email) async {
    LoginScreenModelToken token = await _repoLocalSsToken.find(email);
    return token.bearer;
  }
}
