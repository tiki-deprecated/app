/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_blockchain/repository/api_blockchain_repository_address.dart';
import 'package:app/src/utils/api/helper_api_auth.dart';
import 'package:app/src/utils/api/helper_api_rsp.dart';

import 'model/api_blockchain_model_address_req.dart';
import 'model/api_blockchain_model_address_rsp.dart';
import 'model/api_blockchain_model_address_rsp_code.dart';

class ApiBlockchainService {
  final HelperApiAuth helperApiAuth;

  ApiBlockchainService(this.helperApiAuth);

  Future<HelperApiRsp<ApiBlockchainModelAddressRsp>> issue(
          ApiBlockchainModelAddressReq req) async =>
      await helperApiAuth.proxy(() =>
          ApiBlockchainRepositoryAddress.issue(helperApiAuth.bearer, req));

  Future<HelperApiRsp<ApiBlockchainModelAddressRspCode>> referCode(
          String address) async =>
      await helperApiAuth.proxy(() => ApiBlockchainRepositoryAddress.referCode(
          helperApiAuth.bearer, address));
}
