/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_sentry.dart';
import 'package:app/src/slices/api_bouncer/api_bouncer_service.dart';
import 'package:app/src/slices/api_bouncer/model/api_bouncer_model_jwt_rsp.dart';
import 'package:app/src/slices/api_user/model/api_user_model_token.dart';
import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:app/src/utils/api/helper_api_utils.dart';

import 'helper_api_rsp.dart';

class HelperApiAuth {
  final LoginFlowService loginFlowService;
  final ApiBouncerService apiBouncerService;

  HelperApiAuth(this.loginFlowService, this.apiBouncerService);

  Future<HelperApiRsp<T>> proxy<T>(
      Future<HelperApiRsp<T>> Function() request) async {
    HelperApiRsp<T> rsp = await request();
    if (HelperApiUtils.isUnauthorized(rsp.code)) {
      ApiUserModelToken? token = loginFlowService.model.user?.token;
      if (token == null || token.refresh == null) {
        ConfigSentry.message("No refresh token. Logging out",
            level: ConfigSentry.levelWarn);
        loginFlowService.setLoggedOut();
      } else {
        HelperApiRsp<ApiBouncerModelJwtRsp> refreshRsp =
            await apiBouncerService.refreshGrant(token.refresh!);
        if (HelperApiUtils.is2xx(refreshRsp.code)) {
          ApiBouncerModelJwtRsp jwt = refreshRsp.data;
          await loginFlowService.apiUserService.setToken(
              loginFlowService.model.user!.user!.email!,
              ApiUserModelToken(
                  bearer: jwt.accessToken,
                  refresh: jwt.refreshToken,
                  expiresIn: jwt.expiresIn));
          rsp = await request();
        } else {
          ConfigSentry.message("Failed to refresh. Logging out",
              level: ConfigSentry.levelWarn);
          loginFlowService.setLoggedOut();
        }
      }
    }
    return rsp;
  }

  String? get bearer => loginFlowService.model.user?.token?.bearer;
}
