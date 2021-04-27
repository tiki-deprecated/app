/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'login_email_form_bloc.dart';

abstract class LoginEmailFormEvent extends Equatable {
  final String email;

  const LoginEmailFormEvent(this.email);

  @override
  List<Object> get props => [email];
}

class LoginEmailFormChanged extends LoginEmailFormEvent {
  LoginEmailFormChanged(String email) : super(email);
}

class LoginEmailFormSubmit extends LoginEmailFormEvent {
  LoginEmailFormSubmit(String email) : super(email);
}
