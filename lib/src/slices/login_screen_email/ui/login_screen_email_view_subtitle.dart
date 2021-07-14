import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScreenEmailViewSubtitle extends StatelessWidget {
  static const String _text = "Enter your email below to begin.";

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: ConfigColor.greySix));
  }
}
