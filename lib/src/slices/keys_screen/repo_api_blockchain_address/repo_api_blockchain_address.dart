/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/slices/api/helper_api_auth.dart';
import 'package:app/src/slices/api/helper_api_rsp.dart';
import 'package:app/src/slices/api/helper_headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'repo_api_blockchain_address_refer_rsp.dart';
import 'repo_api_blockchain_address_req.dart';
import 'repo_api_blockchain_address_rsp.dart';

class RepoApiBlockchainAddress {
  static final String _pathIssue = '/api/latest/address/issue';
  static final String _pathRefer = '/api/latest/address/refer';

  final HelperApiAuth _helperApiAuth;

  RepoApiBlockchainAddress(this._helperApiAuth);

  RepoApiBlockchainAddress.provide(BuildContext context)
      : _helperApiAuth = HelperApiAuth.provide(context);

  Future<HelperApiRsp<RepoApiBlockchainAddressRsp>> issue(
      RepoApiBlockchainAddressReq req) async {
    return await _helperApiAuth.proxy(() => _issue(req));
  }

  Future<HelperApiRsp<RepoApiBlockchainAddressRsp>> _issue(
      RepoApiBlockchainAddressReq req) async {
    String? bearer = await _helperApiAuth.bearer();
    http.Response rsp = await http.post(
        ConfigDomain.asUri(ConfigDomain.blockchain, _pathIssue),
        headers: HelperHeaders(auth: bearer).header,
        body: jsonEncode(req.toJson()));
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) => RepoApiBlockchainAddressRsp.fromJson(
            json as Map<String, dynamic>?));
  }

  Future<HelperApiRsp<RepoApiBlockchainAddressReferRsp>> referCount(
      String? address) async {
    return await _helperApiAuth.proxy(() => _referCount(address!));
  }

  Future<HelperApiRsp<RepoApiBlockchainAddressReferRsp>> _referCount(
      String address) async {
    String? bearer = await _helperApiAuth.bearer();
    http.Response rsp = await http.get(
        ConfigDomain.asUri(
            ConfigDomain.blockchain, _pathRefer + "/" + address + "/count"),
        headers: HelperHeaders(auth: bearer).header);
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) => RepoApiBlockchainAddressReferRsp.fromJson(
            json as Map<String, dynamic>?));
  }
}
