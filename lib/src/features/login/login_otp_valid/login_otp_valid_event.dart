/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'login_otp_valid_bloc.dart';

abstract class LoginOtpValidEvent extends Equatable {
  const LoginOtpValidEvent();

  @override
  List<Object> get props => [];
}

class LoginOtpValidChanged extends LoginOtpValidEvent {
  final String otp;

  const LoginOtpValidChanged(this.otp) : super();

  @override
  List<Object> get props => [otp];
}

class LoginOtpValidLoaded extends LoginOtpValidEvent {
  final String otp;

  const LoginOtpValidLoaded(this.otp) : super();

  @override
  List<Object> get props => [otp];
}
