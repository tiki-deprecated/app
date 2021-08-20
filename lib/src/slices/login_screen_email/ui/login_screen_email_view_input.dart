import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../login_screen_email_service.dart';

class LoginScreenEmailViewInput extends StatelessWidget {
  static const num _fontSize = 14;
  static const String _placeholder = "Your email";

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenEmailService>(context);
    return TextField(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize.sp),
        cursorColor: ConfigColor.orange,
        autocorrect: false,
        autofocus: true,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 2.h),
            hintText: _placeholder,
            hintStyle: TextStyle(
                color: ConfigColor.greyFive,
                fontWeight: FontWeight.bold,
                fontSize: _fontSize.sp),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: service.model.isError
                        ? ConfigColor.tikiRed
                        : ConfigColor.tikiPurple,
                    width: 1,
                    style: BorderStyle.solid)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: service.model.isError
                        ? ConfigColor.tikiRed
                        : ConfigColor.tikiPurple,
                    width: 1,
                    style: BorderStyle.solid))),
        onChanged: (input) => service.controller.emailChanged(context, input));
  }
}
