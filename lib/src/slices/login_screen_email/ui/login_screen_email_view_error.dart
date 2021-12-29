/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../login_screen_email_service.dart';

class LoginScreenEmailViewError extends StatelessWidget {
  static const String _text = "Please enter a valid email";

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenEmailService>(context);
    return Opacity(
      opacity: service.model.isError ? 1.0 : 0.0,
      child: Text(_text,
          style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: service.model.isError
                  ? ConfigColor.tikiRed
                  : ConfigColor.cream)),
    );
  }
}
