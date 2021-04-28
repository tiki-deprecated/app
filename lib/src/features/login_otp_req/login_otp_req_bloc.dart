import 'dart:async';

import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp.dart';
import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp_req.dart';
import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp_rsp.dart';
import 'package:app/src/features/repo_local_ss_otp/repo_local_ss_otp.dart';
import 'package:app/src/features/repo_local_ss_otp/repo_local_ss_otp_model.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_otp_req_event.dart';
part 'login_otp_req_state.dart';

class LoginOtpReqBloc extends Bloc<LoginOtpReqEvent, LoginOtpReqState> {
  static const String _ssKey = 'req';
  final RepoApiBouncerOtp repoApiBouncerOtp;
  final RepoLocalSsOtp repoLocalSsOtp;

  LoginOtpReqBloc(this.repoApiBouncerOtp, this.repoLocalSsOtp)
      : super(LoginOtpReqStateInitial());

  LoginOtpReqBloc.provide(BuildContext context)
      : repoApiBouncerOtp = RepositoryProvider.of<RepoApiBouncerOtp>(context),
        repoLocalSsOtp = RepositoryProvider.of<RepoLocalSsOtp>(context),
        super(LoginOtpReqStateInitial());

  @override
  Stream<LoginOtpReqState> mapEventToState(
    LoginOtpReqEvent event,
  ) async* {
    if (event is LoginOtpReqChanged)
      yield* _mapChangedToState(event);
    else if (event is LoginOtpReqSubmit)
      yield* _mapSubmitToState(event);
    else if (event is LoginOtpReqLoad) yield* _mapLoadToState(event);
  }

  Stream<LoginOtpReqState> _mapChangedToState(
      LoginOtpReqChanged changed) async* {
    yield LoginOtpReqStateInProgress(changed.email, _isValid(changed.email));
  }

  Stream<LoginOtpReqState> _mapSubmitToState(LoginOtpReqSubmit submit) async* {
    HelperApiRsp<RepoApiBouncerOtpRsp> rsp =
        await repoApiBouncerOtp.email(RepoApiBouncerOtpReq(submit.email));
    if (rsp.code == 200) {
      RepoApiBouncerOtpRsp rspData = rsp.data;
      await repoLocalSsOtp.save(
          _ssKey, RepoLocalSsOtpModel(email: submit.email, salt: rspData.salt));
      yield LoginOtpReqStateSuccess(submit.email);
    } else {
      yield LoginOtpReqStateFailure(submit.email);
    }
  }

  Stream<LoginOtpReqState> _mapLoadToState(LoginOtpReqLoad resend) async* {
    RepoLocalSsOtpModel model = await repoLocalSsOtp.find(_ssKey);
    yield LoginOtpReqStateInProgress(model.email, _isValid(model.email));
  }

  bool _isValid(String s) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(s);
  }
}
