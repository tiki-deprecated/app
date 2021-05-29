/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/login/login_otp/login_otp_req/bloc/login_otp_req_bloc.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TikiBackButton extends StatelessWidget {
  static const String _text = "Back";
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;
  static final double _marginRightArrow =
      1 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        LoginOtpReqBloc bloc = BlocProvider.of<LoginOtpReqBloc>(context);
        bloc.add(LoginOtpReqChanged(bloc.state.email ?? ''));
        Navigator.of(context).pop();
      },
      child: Row(children: [
        Container(
          child: HelperImage('back-arrow'),
          margin: EdgeInsets.only(right: _marginRightArrow),
        ),
        Text(_text,
            style: TextStyle(
                color: ConfigColor.orange,
                fontWeight: FontWeight.w800,
                fontSize: _fontSize))
      ]),
    );
  }
}