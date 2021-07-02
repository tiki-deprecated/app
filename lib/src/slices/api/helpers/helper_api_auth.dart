/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api/helpers/helper_api_rsp.dart';
import 'package:app/src/slices/app/model/app_model_current.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_current.dart';
import 'package:app/src/slices/auth/model/auth_bouncer_jwt_req_refresh.dart';
import 'package:app/src/slices/auth/model/auth_bouncer_jwt_rsp.dart';
import 'package:app/src/slices/auth/model/auth_model_token.dart';
import 'package:app/src/slices/auth/repository/auth_bouncer_jwt.dart';
import 'package:app/src/slices/auth/repository/secure_storage_repository_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class HelperApiAuth {
  final SecureStorageRepositoryCurrent _secureStorageRepositoryCurrent;
  final SecureStorageRepositoryToken _repoLocalSsToken;

  HelperApiAuth(this._secureStorageRepositoryCurrent, this._repoLocalSsToken);

  HelperApiAuth.provide()
      : _secureStorageRepositoryCurrent = SecureStorageRepositoryCurrent(
            secureStorage: FlutterSecureStorage()),
        _repoLocalSsToken =
            SecureStorageRepositoryToken(secureStorage: FlutterSecureStorage());

  Future<HelperApiRsp<T>> proxy<T>(
      Future<HelperApiRsp<T>> Function() request) async {
    HelperApiRsp<T> rsp = await request();
    if (rsp.code == 401) {
      AppModelCurrent current = await _secureStorageRepositoryCurrent
          .find(SecureStorageRepositoryCurrent.key);
      AuthModelToken token = await _repoLocalSsToken.find(current.email!);
      if (token.refresh == null) {
        Sentry.captureMessage("No refresh token. Logging out",
            level: SentryLevel.warning);
        rsp = HelperApiRsp(code: 401);
        //TODO NEED TO LOG USER OUT HERE
      } else {
        HelperApiRsp<AuthBouncerJwtRsp> refreshRsp =
            await AuthBouncerJwt.refresh(AuthModelJwtReqRefresh(token.refresh));
        if (refreshRsp.code == 200) {
          AuthBouncerJwtRsp jwt = refreshRsp.data;
          _repoLocalSsToken.save(
              current.email!,
              AuthModelToken(
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
    AppModelCurrent current = await _secureStorageRepositoryCurrent
        .find(SecureStorageRepositoryCurrent.key);
    AuthModelToken token = await _repoLocalSsToken.find(current.email!);
    return token.bearer;
  }

  Future<String?> bearerForUser(String email) async {
    AuthModelToken token = await _repoLocalSsToken.find(email);
    return token.bearer;
  }
}
