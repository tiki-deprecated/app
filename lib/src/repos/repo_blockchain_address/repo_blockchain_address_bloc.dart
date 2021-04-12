/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/configs/config_domains.dart' as Domains;
import 'package:app/src/helpers/helper_auth_proxy/helper_auth_proxy_bloc.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address_model_req.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address_model_rsp.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:http/http.dart' as http;

class RepoBlockchainAddressBloc {
  static final String _path = '/api/latest/address/issue';
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
        envAwareUri(Domains.of(Domains.blockchain), _path),
        headers: jsonHeaders(auth: user.bearer),
        body: jsonEncode(req.toJson()));
    Map rspMap = jsonDecode(rsp.body);
    return UtilityAPIRsp.fromJson(
        rspMap, (json) => RepoBlockchainAddressModelRsp.fromJson(json));
  }
}
