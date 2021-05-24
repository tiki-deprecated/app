/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/login/login_otp/login_otp_valid/bloc/login_otp_valid_bloc.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginOtpScreenLoad extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginOtpScreenLoad();
}

class _LoginOtpScreenLoad extends State<LoginOtpScreenLoad> {
  @override
  void initState() {
    super.initState();
    LoginOtpValidBloc bloc = BlocProvider.of<LoginOtpValidBloc>(context);
    if (bloc.state is LoginOtpValidInProgress)
      bloc.add(
          LoginOtpValidLoaded((bloc.state as LoginOtpValidInProgress).otp));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: ConfigColor.sunglow)),
      Align(alignment: Alignment.topLeft, child: HelperImage('splash-blob-tl')),
      Stack(children: [
        Center(child: HelperImage('splash-logo-bkg')),
        Center(child: HelperImage('splash-logo'))
      ]),
      Align(
          alignment: Alignment.bottomRight,
          child: HelperImage('splash-blob-br')),
    ]);
  }
}
