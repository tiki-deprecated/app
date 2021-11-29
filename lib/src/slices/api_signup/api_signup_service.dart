/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../utils/api/helper_api_rsp.dart';
import '../tiki_http/tiki_http_client.dart';
import 'model/api_signup_model_user_rsp.dart';
import 'repository/api_signup_repository.dart';

class ApiSignupService {
  Future<HelperApiRsp<ApiSignupModelUserRsp>> getTotalRsp(
          {String? code}) async =>
      await ApiSignupRepository.total(code: code);

  Future<int?> getTotal({String? code}) async {
    HelperApiRsp<ApiSignupModelUserRsp> rsp = await getTotalRsp(code: code);
    if (TikiHttpClient.isOk(rsp.code)) {
      ApiSignupModelUserRsp data = rsp.data;
      return data.total;
    } else
      return null;
  }
}
