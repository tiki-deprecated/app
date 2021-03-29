/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_bouncer_otp/repo_bouncer_otp_bloc.dart';
import 'package:app/src/repos/repo_bouncer_otp/repo_bouncer_otp_model_req.dart';
import 'package:app/src/repos/repo_bouncer_otp/repo_bouncer_otp_model_rsp.dart';
import 'package:app/src/ui/ui_magiclink_send/ui_magic_link_model.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UIMagicLinkBloc {
  UIMagicLinkModel _magicLinkModel;
  RepoBouncerOtpBloc _repoBouncerOtpBloc;
  BehaviorSubject<UIMagicLinkModel> _subjectModel;
  SharedPreferences _sharedPreferences;

  UIMagicLinkBloc(this._repoBouncerOtpBloc) {
    _magicLinkModel = UIMagicLinkModel();
    _subjectModel = BehaviorSubject.seeded(_magicLinkModel);
    _initPreferences();
  }

  Observable<UIMagicLinkModel> get observableModel => _subjectModel.stream;

  void checkInput(String input) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input)) {
      _magicLinkModel.isReady = true;
      _magicLinkModel.email = input;
    } else
      _magicLinkModel.isReady = false;
    _subjectModel.sink.add(_magicLinkModel);
  }

  Future<bool> send() async {
    _magicLinkModel.isReady = false;
    _subjectModel.sink.add(_magicLinkModel);
    UtilityAPIRsp<RepoBouncerOtpModelRsp> rsp = await _repoBouncerOtpBloc
        .email(RepoBouncerOtpModelReq(_magicLinkModel.email));
    if (rsp.code == 200) {
      RepoBouncerOtpModelRsp otp = rsp.data;
      _magicLinkModel.salt = otp.salt;
      _magicLinkModel.isError = false;
      if (_sharedPreferences == null)
        _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString(
          "magic_link.email", _magicLinkModel.email);
      await _sharedPreferences.setString(
          "magic_link.salt", _magicLinkModel.salt);
      _subjectModel.sink.add(_magicLinkModel);
      return true;
    } else {
      _magicLinkModel.isError = true;
      _subjectModel.sink.add(_magicLinkModel);
      return false;
    }
  }

  Future<void> _initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void dispose() {
    _subjectModel.close();
  }
}
