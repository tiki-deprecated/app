/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_bouncer/api_bouncer_service.dart';
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
      await loginFlowService.refreshAuth();
      rsp = await request();
    }
    return rsp;
  }

  String? get bearer => loginFlowService.model.user?.token?.bearer;
}
