/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_company_index/model/api_company_index_model_rsp.dart';
import 'package:app/src/utils/api/helper_api_auth.dart';
import 'package:app/src/utils/api/helper_api_rsp.dart';

import 'repository/api_company_index_repository.dart';

class ApiCompanyIndexService {
  final HelperApiAuth helperApiAuth;

  ApiCompanyIndexService(this.helperApiAuth);

  Future<HelperApiRsp<ApiCompanyIndexModelRsp>> find(String domain) async =>
      await helperApiAuth.proxy(
          () => ApiCompanyIndexRepository.find(helperApiAuth.bearer, domain));
}
