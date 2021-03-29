/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login_router/helper_login_router_model.dart';
import 'package:app/src/helpers/helper_login_router/helper_login_router_model_state.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_req.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_rsp.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:uuid/uuid.dart';

class HelperLoginRouterBloc {
  RepoSSUserBloc _repoSSUserBloc;
  RepoBouncerJwtBloc _repoBouncerJwtBloc;
  HelperLoginRouterModel _helperLoginRouterModel = HelperLoginRouterModel();
  SharedPreferences _sharedPreferences;
  BehaviorSubject<HelperLoginRouterModel> _behaviorSubject;

  HelperLoginRouterBloc(this._repoSSUserBloc, this._repoBouncerJwtBloc) {
    _behaviorSubject = BehaviorSubject.seeded(_helperLoginRouterModel);
    getInitialLink().then((link) => _processDeeplink(link));
    getLinksStream().listen((link) => _processDeeplink(link));
    _initPreferences();
  }

  Future<void> login() async {
    if (await _routeLoggedIn())
      return;
    else if (await _routeCreate())
      return;
    else
      _routeLoggedOut();
  }

  Observable<HelperLoginRouterModel> get observable => _behaviorSubject.stream;

  Future<void> _processDeeplink(String link) async {
    if (link != null) {
      Uri uri = Uri.parse(link);
      if (uri != null) {
        if (uri.authority == "bouncer") {
          String otp = uri.queryParameters["otp"];
          if (_helperLoginRouterModel.otp == null ||
              _helperLoginRouterModel.otp != otp) {
            _helperLoginRouterModel.otp = otp;
            login();
          }
        }
      }
    }
  }

  Future<void> _initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> _routeLoggedIn() async {
    RepoSSUserModel user = await _repoSSUserBloc.find();
    if (user != null &&
        user.email != null &&
        user.uuid != null &&
        user.loggedIn == true) {
      _helperLoginRouterModel.email = user.email;
      _helperLoginRouterModel.state = HelperLoginRouterModelState.loggedIn;
      _behaviorSubject.sink.add(_helperLoginRouterModel);
      return true;
    }
    return false;
  }

  Future<bool> _routeCreate() async {
    if (_helperLoginRouterModel.otp != null) {
      if (_sharedPreferences == null)
        _sharedPreferences = await SharedPreferences.getInstance();
      String magicLinkEmail = _sharedPreferences.get("magic_link.email");
      String magicLinkSalt = _sharedPreferences.get("magic_link.salt");
      if (magicLinkEmail == null || magicLinkSalt == null) return false;
      UtilityAPIRsp<RepoBouncerJwtModelRsp> rsp = await _repoBouncerJwtBloc.otp(
          RepoBouncerJwtModelReq(_helperLoginRouterModel.otp, magicLinkSalt));
      if (rsp.code != 200) return false;
      RepoBouncerJwtModelRsp jwt = rsp.data;
      await _repoSSUserBloc.save(RepoSSUserModel(
          uuid: Uuid().v4(),
          email: magicLinkEmail,
          loggedIn: true,
          bearer: jwt.accessToken,
          refresh: jwt.refreshToken));
      _helperLoginRouterModel.email = magicLinkEmail;
      _helperLoginRouterModel.refresh = jwt.refreshToken;
      _helperLoginRouterModel.bearer = jwt.accessToken;
      _helperLoginRouterModel.state = HelperLoginRouterModelState.create;
      _behaviorSubject.sink.add(_helperLoginRouterModel);
      return true;
    }
    return false;
  }

  void _routeLoggedOut() {
    _helperLoginRouterModel.email = null;
    _helperLoginRouterModel.otp = null;
    _helperLoginRouterModel.bearer = null;
    _helperLoginRouterModel.refresh = null;
    _helperLoginRouterModel.state = HelperLoginRouterModelState.loggedOut;
    _behaviorSubject.sink.add(_helperLoginRouterModel);
  }

  void dispose() {
    _behaviorSubject.close();
  }
}
