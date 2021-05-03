/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'login_otp_req_bloc.dart';

abstract class LoginOtpReqState extends Equatable {
  final String email;

  const LoginOtpReqState(this.email);

  @override
  List<Object> get props => [email];
}

class LoginOtpReqStateInitial extends LoginOtpReqState {
  LoginOtpReqStateInitial() : super(null);
}

class LoginOtpReqStateInProgress extends LoginOtpReqState {
  final bool isValid;

  const LoginOtpReqStateInProgress(String email, this.isValid) : super(email);

  @override
  List<Object> get props => [email, isValid];
}

class LoginOtpReqStateSuccess extends LoginOtpReqState {
  const LoginOtpReqStateSuccess(String email) : super(email);
}

class LoginOtpReqStateFailure extends LoginOtpReqState {
  const LoginOtpReqStateFailure(String email) : super(email);
}
