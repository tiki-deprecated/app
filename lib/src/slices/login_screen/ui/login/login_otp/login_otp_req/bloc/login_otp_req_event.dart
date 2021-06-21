/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'login_otp_req_bloc.dart';

abstract class LoginOtpReqEvent extends Equatable {
  const LoginOtpReqEvent();

  @override
  List<Object?> get props => [];
}

class LoginOtpReqChanged extends LoginOtpReqEvent {
  final String email;

  const LoginOtpReqChanged(this.email) : super();

  @override
  List<Object> get props => [email];
}

class LoginOtpReqSubmitted extends LoginOtpReqEvent {
  final String? email;

  const LoginOtpReqSubmitted(this.email) : super();

  @override
  List<Object?> get props => [email];
}
