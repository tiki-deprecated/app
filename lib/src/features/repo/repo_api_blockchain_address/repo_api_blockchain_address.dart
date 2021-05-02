/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/features/repo/repo_api_blockchain_address/repo_api_blockchain_address_refer_rsp.dart';
import 'package:app/src/features/repo/repo_api_blockchain_address/repo_api_blockchain_address_req.dart';
import 'package:app/src/features/repo/repo_api_blockchain_address/repo_api_blockchain_address_rsp.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/features/repo/repo_local_ss_token/repo_local_ss_token.dart';
import 'package:app/src/features/repo/repo_local_ss_token/repo_local_ss_token_model.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:app/src/utils/helper/helper_auth_proxy.dart';
import 'package:app/src/utils/helper/helper_headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class RepoApiBlockchainAddress {
  static final String _pathIssue = '/api/latest/address/issue';
  static final String _pathRefer = '/api/latest/address/refer';

  final RepoLocalSsCurrent _repoLocalSsCurrent;
  final RepoLocalSsToken _repoLocalSsToken;
  final HelperAuthProxy _helperAuthProxy;

  RepoApiBlockchainAddress(
      this._repoLocalSsCurrent, this._repoLocalSsToken, this._helperAuthProxy);

  RepoApiBlockchainAddress.provide(BuildContext context)
      : _repoLocalSsCurrent =
            RepositoryProvider.of<RepoLocalSsCurrent>(context),
        _repoLocalSsToken = RepositoryProvider.of<RepoLocalSsToken>(context),
        _helperAuthProxy = HelperAuthProxy.provide(context);

  Future<HelperApiRsp<RepoApiBlockchainAddressRsp>> issue(
      RepoApiBlockchainAddressReq req) async {
    return await _helperAuthProxy.execute(() => _issue(req));
  }

  Future<HelperApiRsp<RepoApiBlockchainAddressRsp>> _issue(
      RepoApiBlockchainAddressReq req) async {
    RepoLocalSsCurrentModel current =
        await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
    RepoLocalSsTokenModel token = await _repoLocalSsToken.find(current.email);
    http.Response rsp = await http.post(
        ConfigDomain.asUri(ConfigDomain.blockchain, _pathIssue),
        headers: HelperHeaders(auth: token.bearer).header,
        body: jsonEncode(req.toJson()));
    Map rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap, (json) => RepoApiBlockchainAddressRsp.fromJson(json));
  }

  Future<HelperApiRsp<RepoApiBlockchainAddressReferRsp>> referCount(
      String address) async {
    return await _helperAuthProxy.execute(() => _referCount(address));
  }

  Future<HelperApiRsp<RepoApiBlockchainAddressReferRsp>> _referCount(
      String address) async {
    RepoLocalSsCurrentModel current =
        await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
    RepoLocalSsTokenModel token = await _repoLocalSsToken.find(current.email);
    http.Response rsp = await http.get(
        ConfigDomain.asUri(
            ConfigDomain.blockchain, _pathRefer + "/" + address + "/count"),
        headers: HelperHeaders(auth: token.bearer).header);
    Map rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap, (json) => RepoApiBlockchainAddressReferRsp.fromJson(json));
  }
}
