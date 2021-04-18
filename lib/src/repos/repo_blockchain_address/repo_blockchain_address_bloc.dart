/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/configs/config_domains.dart' as Domains;
import 'package:app/src/helpers/helper_auth_proxy/helper_auth_proxy_bloc.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address_model_refer_rsp.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address_model_req.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address_model_rsp.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:http/http.dart' as http;

class RepoBlockchainAddressBloc {
  static final String _pathIssue = '/api/latest/address/issue';
  static final String _pathRefer = '/api/latest/address/refer';

  final RepoSSUserBloc _repoSSUserBloc;
  final HelperAuthProxyBloc _helperAuthProxyBloc;

  RepoBlockchainAddressBloc(this._repoSSUserBloc, this._helperAuthProxyBloc);

  Future<UtilityAPIRsp<RepoBlockchainAddressModelRsp>> issue(
      RepoBlockchainAddressModelReq req) async {
    return await _helperAuthProxyBloc.execute(() => _issue(req));
  }

  Future<UtilityAPIRsp<RepoBlockchainAddressModelRsp>> _issue(
      RepoBlockchainAddressModelReq req) async {
    RepoSSUserModel user = await _repoSSUserBloc.find();
    http.Response rsp = await http.post(
        envAwareUri(Domains.of(Domains.blockchain), _pathIssue),
        headers: jsonHeaders(auth: user.bearer),
        body: jsonEncode(req.toJson()));
    Map rspMap = jsonDecode(rsp.body);
    return UtilityAPIRsp.fromJson(
        rspMap, (json) => RepoBlockchainAddressModelRsp.fromJson(json));
  }

  Future<UtilityAPIRsp<RepoBlockchainAddressModelReferRsp>> referCount(
      String address) async {
    return await _helperAuthProxyBloc.execute(() => _referCount(address));
  }

  Future<UtilityAPIRsp<RepoBlockchainAddressModelReferRsp>> _referCount(
      String address) async {
    RepoSSUserModel user = await _repoSSUserBloc.find();
    http.Response rsp = await http.get(
        envAwareUri(Domains.of(Domains.blockchain),
            _pathRefer + "/" + address + "/count"),
        headers: jsonHeaders(auth: user.bearer));
    Map rspMap = jsonDecode(rsp.body);
    return UtilityAPIRsp.fromJson(
        rspMap, (json) => RepoBlockchainAddressModelReferRsp.fromJson(json));
  }
}
