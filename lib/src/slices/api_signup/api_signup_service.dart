/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';

import '../../utils/api/tiki_api_model_rsp.dart';
import 'model/api_signup_model_user_rsp.dart';
import 'repository/api_signup_repository.dart';

class ApiSignupService {
  Future<TikiApiModelRsp<ApiSignupModelUserRsp>> getTotalRsp(
          {String? code}) async =>
      await ApiSignupRepository.total(code: code);

  Future<int?> getTotal({String? code}) async {
    TikiApiModelRsp<ApiSignupModelUserRsp> rsp = await getTotalRsp(code: code);
    if (HttppUtils.isOk(rsp.code)) {
      ApiSignupModelUserRsp data = rsp.data;
      return data.total;
    } else {
      return null;
    }
  }
}
