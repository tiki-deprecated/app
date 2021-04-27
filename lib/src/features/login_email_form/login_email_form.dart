/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/features/login_email_form/login_email_form_bloc.dart';
import 'package:app/src/features/login_email_form/login_email_form_button.dart';
import 'package:app/src/features/login_email_form/login_email_form_error.dart';
import 'package:app/src/features/login_email_form/login_email_form_input_android.dart';
import 'package:app/src/features/login_email_form/login_email_form_input_ios.dart';
import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp_provider.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEmailForm extends StatelessWidget {
  static final double _marginTopButton = 4 * PlatformRelativeSize.blockVertical;

  @override
  Widget build(BuildContext context) {
    RepoApiBouncerOtp repoApiBouncerOtp =
        RepoApiBouncerOtpProvider.of(context).repo;
    return BlocProvider(
        create: (BuildContext context) => LoginEmailFormBloc(repoApiBouncerOtp),
        child: Row(children: [
          Expanded(child: BlocBuilder<LoginEmailFormBloc, LoginEmailFormState>(
            builder: (BuildContext context, LoginEmailFormState state) {
              return Column(
                children: [
                  Platform.isIOS
                      ? LoginEmailFormInputIos(
                          isError: state is LoginEmailFormFailure)
                      : LoginEmailFormInputAndroid(
                          isError: state is LoginEmailFormFailure),
                  LoginEmailFormError(isError: state is LoginEmailFormFailure),
                  Container(
                      margin: EdgeInsets.only(top: _marginTopButton),
                      child: LoginEmailFormButton(
                          isActive: state is LoginEmailFormInProgress
                              ? state.isReady
                              : false)),
                ],
              );
            },
          )),
        ]));
  }
}
