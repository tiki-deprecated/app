/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/app.dart';
import 'package:app/src/helpers/helper_login/helper_login_model.dart';
import 'package:app/src/helpers/helper_login/helper_login_model_state.dart';
import 'package:app/src/platform/platform_page_route.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_req.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_rsp.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/screens/screen_login_otp.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class HelperLoginBloc {
  RepoSSUserBloc _repoSSUserBloc;
  RepoBouncerJwtBloc _repoBouncerJwtBloc;
  HelperLoginModel helperLoginModel = HelperLoginModel();
  SharedPreferences _sharedPreferences;
  BehaviorSubject<HelperLoginModel> _behaviorSubject;

  //TODO SPLIT THIS INTO IS LOGGED IN & OTP LOGIN. IS LOGGED IN SHOULD BE ABLE TO BE CALLED FROM MAIN. OTP LOGIN IS CALLED FROM DEEPLINK.
  //TODO RENAME SPLASH/MOVE INTO DEEPLINK OTP. ON DEEPLINK OTP OPEN SPLASH IMMEDIATELY, USE FUTURE BUILDER.
  //TODO FIX ANDROID SPLASH TO MATCH DESIGN.

  HelperLoginBloc(this._repoSSUserBloc, this._repoBouncerJwtBloc) {
    _behaviorSubject = BehaviorSubject.seeded(helperLoginModel);
  }

  Future<void> beginOtp(String otp) async {
    helperLoginModel = HelperLoginModel(otp: otp);
    navigatorKey.currentState
        .pushAndRemoveUntil(platformPageRoute(ScreenLoginOtp()), (_) => false);
    _behaviorSubject.sink.add(helperLoginModel);
  }

  Future<void> completeOtp() async {
    if (helperLoginModel.semaphore == false) {
      helperLoginModel.semaphore = true;
      RepoSSUserModel user = await getLoggedInUser(_repoSSUserBloc);
      if (user != null) {
        helperLoginModel = HelperLoginModel(
            email: user.email,
            bearer: user.bearer,
            refresh: user.refresh,
            state: HelperLoginModelState.loggedIn,
            semaphore: false);
        helperLoginModel.semaphore = false;
      } else if (!await _executeOtp()) {
        helperLoginModel = HelperLoginModel(
            state: HelperLoginModelState.loggedOut, semaphore: false);
      }
      _behaviorSubject.sink.add(helperLoginModel);
    }
  }

  Observable<HelperLoginModel> get observable => _behaviorSubject.stream;

  static Future<RepoSSUserModel> getLoggedInUser(
      RepoSSUserBloc repoSSUserBloc) async {
    RepoSSUserModel user = await repoSSUserBloc.find();
    if (user != null &&
        user.email != null &&
        user.uuid != null &&
        user.loggedIn == true) {
      return user;
    }
    return null;
  }

  void dispose() {
    _behaviorSubject.close();
  }

  Future<bool> _executeOtp() async {
    if (helperLoginModel.otp == null) return false;
    if (_sharedPreferences == null)
      _sharedPreferences = await SharedPreferences.getInstance();

    String magicLinkEmail = _sharedPreferences.get("magic_link.email");
    String magicLinkSalt = _sharedPreferences.get("magic_link.salt");
    if (magicLinkEmail == null || magicLinkSalt == null) return false;

    UtilityAPIRsp<RepoBouncerJwtModelRsp> rsp = await _repoBouncerJwtBloc
        .otp(RepoBouncerJwtModelReq(helperLoginModel.otp, magicLinkSalt));
    if (rsp.code != 200) return false;

    RepoBouncerJwtModelRsp jwt = rsp.data;
    await _repoSSUserBloc.save(RepoSSUserModel(
        uuid: Uuid().v4(),
        email: magicLinkEmail,
        loggedIn: true,
        bearer: jwt.accessToken,
        refresh: jwt.refreshToken));

    helperLoginModel = new HelperLoginModel(
        email: magicLinkEmail,
        refresh: jwt.refreshToken,
        bearer: jwt.accessToken,
        state: HelperLoginModelState.creating,
        semaphore: false);
    return true;
  }
}
