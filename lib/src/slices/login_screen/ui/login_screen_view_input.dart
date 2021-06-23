import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../login_screen_service.dart';

class LoginScreenViewInput extends StatelessWidget {
  static const String _placeholder = "Your email";
  static final double _paddingHorizontal = 4.w;
  static final double _paddingVertical = 2.h;
  static final double _fontSize = 5.w;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return Container(
        margin: EdgeInsets.only(top: service.presenter.marginTopInput),
        child: TextField(
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize),
            cursorColor: ConfigColor.orange,
            autocorrect: false,
            autofocus: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: _paddingHorizontal, vertical: _paddingVertical),
                hintText: _placeholder,
                hintStyle: TextStyle(
                    color: ConfigColor.gray,
                    fontWeight: FontWeight.bold,
                    fontSize: _fontSize),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: service.model.isError
                            ? ConfigColor.grenadier
                            : ConfigColor.mardiGras,
                        width: 2,
                        style: BorderStyle.solid)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: service.model.isError
                            ? ConfigColor.grenadier
                            : ConfigColor.mardiGras,
                        width: 2,
                        style: BorderStyle.solid))),
            onChanged: (input) =>
                service.controller.emailChanged(context, input)));
  }
}
