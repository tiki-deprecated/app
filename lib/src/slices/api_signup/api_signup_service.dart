/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_signup/repository/api_signup_repository.dart';
import 'package:app/src/utils/api/helper_api_rsp.dart';
import 'package:app/src/utils/api/helper_api_utils.dart';

import 'model/api_signup_model_user_rsp.dart';

class ApiSignupService {
  Future<HelperApiRsp<ApiSignupModelUserRsp>> getTotalRsp(
          {String? code}) async =>
      await ApiSignupRepository.total(code: code);

  Future<int?> getTotal({String? code}) async {
    HelperApiRsp<ApiSignupModelUserRsp> rsp = await getTotalRsp(code: code);
    if (HelperApiUtils.isOk(rsp.code)) {
      ApiSignupModelUserRsp data = rsp.data;
      return data.total;
    } else
      return null;
  }
}
