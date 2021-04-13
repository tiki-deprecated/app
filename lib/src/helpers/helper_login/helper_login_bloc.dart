/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login/helper_login_model.dart';
import 'package:app/src/helpers/helper_login/helper_login_model_state.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_req_otp.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_rsp.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class HelperLoginBloc {
  RepoSSUserBloc _repoSSUserBloc;
  RepoBouncerJwtBloc _repoBouncerJwtBloc;
  HelperLoginModel _helperLoginModel = HelperLoginModel();
  SharedPreferences _sharedPreferences;

  HelperLoginBloc(this._repoSSUserBloc, this._repoBouncerJwtBloc);

  Future<HelperLoginModel> loginOtp(String otp) async {
    if (_helperLoginModel.semaphore == false) {
      _helperLoginModel.semaphore = true;
      _helperLoginModel.otp = otp;
      RepoSSUserModel user = await _repoSSUserBloc.find();
      if (user != null && user.loggedIn) {
        return HelperLoginModel(
            email: user.email,
            bearer: user.bearer,
            refresh: user.refresh,
            state: HelperLoginModelState.loggedIn,
            semaphore: false);
      } else {
        HelperLoginModel loginModel = await _executeOtp();
        if (loginModel == null)
          return HelperLoginModel(
              state: HelperLoginModelState.loggedOut, semaphore: false);
        else
          return loginModel;
      }
    }
    return null;
  }

  static Future<RepoSSUserModel> getLoggedInUser(
      RepoSSUserBloc repoSSUserBloc) async {
    RepoSSUserModel user = await repoSSUserBloc.find();
    if (user != null &&
        user.email != null &&
        user.uuid != null &&
        user.loggedIn) {
      return user;
    }
    return null;
  }

  Future<HelperLoginModel> _executeOtp() async {
    if (_helperLoginModel.otp == null) return null;
    if (_sharedPreferences == null)
      _sharedPreferences = await SharedPreferences.getInstance();
    String magicLinkEmail = _sharedPreferences.get("magic_link.email");
    String magicLinkSalt = _sharedPreferences.get("magic_link.salt");
    if (magicLinkEmail == null || magicLinkSalt == null) return null;

    UtilityAPIRsp<RepoBouncerJwtModelRsp> rsp = await _repoBouncerJwtBloc
        .otp(RepoBouncerJwtModelReqOtp(_helperLoginModel.otp, magicLinkSalt));
    if (rsp.code != 200) return null;

    RepoSSUserModel user = await _repoSSUserBloc.find();
    String ssUserEmail = user?.email;

    RepoBouncerJwtModelRsp jwt = rsp.data;
    await _repoSSUserBloc.save(RepoSSUserModel(
        uuid: Uuid().v4(),
        email: magicLinkEmail,
        loggedIn: true,
        bearer: jwt.accessToken,
        refresh: jwt.refreshToken));

    return HelperLoginModel(
        email: magicLinkEmail,
        refresh: jwt.refreshToken,
        bearer: jwt.accessToken,
        state: ssUserEmail != null && ssUserEmail == magicLinkEmail
            ? HelperLoginModelState.loggedIn
            : HelperLoginModelState.creating,
        semaphore: false);
  }
}
