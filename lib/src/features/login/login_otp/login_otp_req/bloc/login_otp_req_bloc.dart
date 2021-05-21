import 'dart:async';

import 'package:app/src/features/repo/repo_api_bouncer_otp/repo_api_bouncer_otp.dart';
import 'package:app/src/features/repo/repo_api_bouncer_otp/repo_api_bouncer_otp_req.dart';
import 'package:app/src/features/repo/repo_api_bouncer_otp/repo_api_bouncer_otp_rsp.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/features/repo/repo_local_ss_otp/repo_local_ss_otp.dart';
import 'package:app/src/features/repo/repo_local_ss_otp/repo_local_ss_otp_model.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_otp_req_event.dart';
part 'login_otp_req_state.dart';

class LoginOtpReqBloc extends Bloc<LoginOtpReqEvent, LoginOtpReqState> {
  static const String _ssKey = 'req';
  final RepoApiBouncerOtp _repoApiBouncerOtp;
  final RepoLocalSsOtp _repoLocalSsOtp;
  final RepoLocalSsCurrent _repoLocalSsCurrent;

  LoginOtpReqBloc(
      this._repoApiBouncerOtp, this._repoLocalSsOtp, this._repoLocalSsCurrent)
      : super(LoginOtpReqStateInitial());

  LoginOtpReqBloc.provide(BuildContext context)
      : _repoApiBouncerOtp = RepositoryProvider.of<RepoApiBouncerOtp>(context),
        _repoLocalSsOtp = RepositoryProvider.of<RepoLocalSsOtp>(context),
        _repoLocalSsCurrent =
            RepositoryProvider.of<RepoLocalSsCurrent>(context),
        super(LoginOtpReqStateInitial());

  @override
  Stream<LoginOtpReqState> mapEventToState(LoginOtpReqEvent event) async* {
    if (event is LoginOtpReqChanged)
      yield* _mapChangedToState(event);
    else if (event is LoginOtpReqSubmitted) yield* _mapSubmittedToState(event);
  }

  Stream<LoginOtpReqState> _mapChangedToState(
      LoginOtpReqChanged changed) async* {
    yield LoginOtpReqStateInProgress(changed.email, _isValid(changed.email));
  }

  Stream<LoginOtpReqState> _mapSubmittedToState(
      LoginOtpReqSubmitted submitted) async* {
    print("mapsubmitted");
    HelperApiRsp<RepoApiBouncerOtpRsp> rsp =
        await _repoApiBouncerOtp.email(RepoApiBouncerOtpReq(submitted.email));
    if (rsp.code == 200) {
      RepoApiBouncerOtpRsp rspData = rsp.data;
      await _repoLocalSsOtp.save(_ssKey,
          RepoLocalSsOtpModel(email: submitted.email, salt: rspData.salt));
      await _repoLocalSsCurrent.save(RepoLocalSsCurrent.key,
          RepoLocalSsCurrentModel(email: submitted.email));
      yield LoginOtpReqStateSuccess(submitted.email);
    } else {
      yield LoginOtpReqStateFailure(submitted.email);
    }
  }

  bool _isValid(String email) {
    return EmailValidator.validate(email);
  }
}
