/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/configs/config_domains.dart' as Domains;
import 'package:app/src/helpers/helper_auth_proxy/helper_auth_proxy_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_req_otp.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_rsp.dart';
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

  Future<UtilityAPIRsp<RepoBouncerJwtModelRsp>> issue(
      RepoBouncerJwtModelReqOtp req) async {
    return await _helperAuthProxyBloc.execute(() => _issue(req));
  }

  Future<UtilityAPIRsp<RepoBouncerJwtModelRsp>> _issue(
      RepoBouncerJwtModelReqOtp req) async {
    RepoSSUserModel user = await _repoSSUserBloc.find();
    http.Response rsp = await http.post(
        Uri.https(Domains.of(Domains.blockchain), _path),
        headers: jsonHeaders(auth: user.bearer),
        body: jsonEncode(req.toJson()));
    Map rspMap = jsonDecode(rsp.body);
    return UtilityAPIRsp.fromJson(
        rspMap, (json) => RepoBouncerJwtModelRsp.fromJson(json));
  }
}
