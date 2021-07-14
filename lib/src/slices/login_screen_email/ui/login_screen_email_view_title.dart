import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScreenEmailViewTitle extends StatelessWidget {
  static const String _text = "Hey, nice to see you here";

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: 'Koara', fontSize: 28.sp, fontWeight: FontWeight.bold));
  }
}
