import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../login_screen_service.dart';

class LoginScreenViewInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return TextField(
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: service.presenter.inputFontSize.sp),
        cursorColor: ConfigColor.orange,
        autocorrect: false,
        autofocus: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: service.presenter.inputPaddingHorizontal.h,
                vertical: service.presenter.inputPaddingVertical.h),
            hintText: service.presenter.inputPlaceholder,
            hintStyle: TextStyle(
                color: ConfigColor.gray,
                fontWeight: FontWeight.bold,
                fontSize: service.presenter.inputFontSize.sp),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: service.model.isError
                        ? ConfigColor.grenadier
                        : ConfigColor.mardiGras,
                    width: 1,
                    style: BorderStyle.solid)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: service.model.isError
                        ? ConfigColor.grenadier
                        : ConfigColor.mardiGras,
                    width: 1,
                    style: BorderStyle.solid))),
        onChanged: (input) => service.controller.emailChanged(context, input));
  }
}
