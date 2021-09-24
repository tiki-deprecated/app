/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../utils/api/helper_api_rsp.dart';
import 'model/api_bouncer_model_jwt_req_otp.dart';
import 'model/api_bouncer_model_jwt_req_refresh.dart';
import 'model/api_bouncer_model_jwt_rsp.dart';
import 'model/api_bouncer_model_otp_req.dart';
import 'model/api_bouncer_model_otp_rsp.dart';
import 'repository/api_bouncer_repository_jwt.dart';
import 'repository/api_bouncer_repository_otp.dart';

class ApiBouncerService {
  Future<HelperApiRsp<ApiBouncerModelJwtRsp>> refreshGrant(
          String refreshToken) =>
      ApiBouncerRepositoryJwt.refresh(
          ApiBouncerModelJwtReqRefresh(refreshToken));

  Future<HelperApiRsp<ApiBouncerModelJwtRsp>> otpGrant(
          String otp, String salt) =>
      ApiBouncerRepositoryJwt.otp(ApiBouncerModelJwtReqOtp(otp, salt));

  Future<HelperApiRsp<ApiBouncerModelOtpRsp>> otpRequest(String email) =>
      ApiBouncerRepositoryOtp.email(ApiBouncerModelOtpReq(email));
}
