/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/slices/api/helpers/helper_api_auth.dart';
import 'package:app/src/slices/api/helpers/helper_api_rsp.dart';
import 'package:app/src/slices/api/helpers/helper_headers.dart';
import 'package:app/src/slices/blockchain/model/blockchain_model_address_rsp_code.dart';
import 'package:http/http.dart' as http;

import '../model/blockchain_model_address_refer_rsp.dart';
import '../model/blockchain_model_address_req.dart';
import '../model/blockchain_model_address_rsp.dart';

class BlockchainRepositoryAddress {
  static final String _pathAddress = '/api/latest/address';
  static final String _pathIssue = '/api/latest/address/issue';
  static final String _pathRefer = '/api/latest/address/refer';

  final HelperApiAuth _helperApiAuth;

  BlockchainRepositoryAddress(this._helperApiAuth);

  BlockchainRepositoryAddress.provide()
      : _helperApiAuth = HelperApiAuth.provide();

  Future<HelperApiRsp<BlockchainModelAddressRsp>> issue(
      BlockchainModelAddressReq req) async {
    return await _helperApiAuth.proxy(() => _issue(req));
  }

  Future<HelperApiRsp<BlockchainModelAddressRsp>> _issue(
      BlockchainModelAddressReq req) async {
    String? bearer = await _helperApiAuth.bearer();
    http.Response rsp = await http.post(
        ConfigDomain.asUri(ConfigDomain.blockchain, _pathIssue),
        headers: HelperHeaders(auth: bearer).header,
        body: jsonEncode(req.toJson()));
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) =>
            BlockchainModelAddressRsp.fromJson(json as Map<String, dynamic>?));
  }

  @Deprecated("Use signup API")
  Future<HelperApiRsp<RepoModelAddressReferRsp>> referCount(
      String? address) async {
    return await _helperApiAuth.proxy(() => _referCount(address!));
  }

  @Deprecated("Use signup API")
  Future<HelperApiRsp<RepoModelAddressReferRsp>> _referCount(
      String address) async {
    String? bearer = await _helperApiAuth.bearer();
    http.Response rsp = await http.get(
        ConfigDomain.asUri(
            ConfigDomain.blockchain, _pathRefer + "/" + address + "/count"),
        headers: HelperHeaders(auth: bearer).header);
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) =>
            RepoModelAddressReferRsp.fromJson(json as Map<String, dynamic>?));
  }

  Future<HelperApiRsp<BlockchainModelAddressRspCode>> referCode(
      String address) async {
    return await _helperApiAuth.proxy(() => _referCode(address));
  }

  Future<HelperApiRsp<BlockchainModelAddressRspCode>> _referCode(
      String address) async {
    String? bearer = await _helperApiAuth.bearer();
    http.Response rsp = await http.get(
        ConfigDomain.asUri(
            ConfigDomain.blockchain, _pathAddress + "/" + address + "/code"),
        headers: HelperHeaders(auth: bearer).header);
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) => BlockchainModelAddressRspCode.fromJson(
            json as Map<String, dynamic>?));
  }
}
