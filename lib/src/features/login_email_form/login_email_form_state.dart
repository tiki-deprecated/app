/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'login_email_form_bloc.dart';

abstract class LoginEmailFormState extends Equatable {
  final String email;

  const LoginEmailFormState(this.email);

  @override
  List<Object> get props => [email];
}

class LoginEmailFormInitial extends LoginEmailFormState {
  LoginEmailFormInitial() : super(null);
}

class LoginEmailFormInProgress extends LoginEmailFormState {
  final bool isReady;

  LoginEmailFormInProgress(String email, this.isReady) : super(email);

  @override
  List<Object> get props => [email, isReady];
}

class LoginEmailFormSuccess extends LoginEmailFormState {
  LoginEmailFormSuccess(String email) : super(email);
}

class LoginEmailFormFailure extends LoginEmailFormState {
  LoginEmailFormFailure(String email) : super(email);
}
