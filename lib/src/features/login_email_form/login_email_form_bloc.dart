import 'dart:async';

import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp.dart';
import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp_req.dart';
import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp_rsp.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_email_form_event.dart';
part 'login_email_form_state.dart';

class LoginEmailFormBloc
    extends Bloc<LoginEmailFormEvent, LoginEmailFormState> {
  final RepoApiBouncerOtp repoApiBouncerOtp;
  LoginEmailFormBloc(this.repoApiBouncerOtp) : super(LoginEmailFormInitial());

  @override
  Stream<LoginEmailFormState> mapEventToState(
    LoginEmailFormEvent event,
  ) async* {
    if (event is LoginEmailFormChanged)
      yield* _mapChangedToState(event);
    else if (event is LoginEmailFormSubmit) yield* _mapSubmitToState(event);
  }

  Stream<LoginEmailFormState> _mapChangedToState(
      LoginEmailFormChanged changed) async* {
    bool isReady = false;
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(changed.email)) isReady = true;
    yield LoginEmailFormInProgress(changed.email, isReady);
  }

  Stream<LoginEmailFormState> _mapSubmitToState(
      LoginEmailFormSubmit submit) async* {
    HelperApiRsp<RepoApiBouncerOtpRsp> rsp =
        await repoApiBouncerOtp.email(RepoApiBouncerOtpReq(submit.email));
    if (rsp.code == 200) {
      //TODO we need to temp-cache this data (email + salt)
      yield LoginEmailFormSuccess(submit.email);
    } else {
      yield LoginEmailFormFailure(submit.email);
    }
  }
}
