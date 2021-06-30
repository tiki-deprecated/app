/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysNewScreenDialogCopyButton extends StatelessWidget {
  static const String _buttonText = "COPY";
  static final double _borderRadius = 2.w;
  static final double _paddingHorizontal = 2.w;
  static final double _paddingHorizontalIcon = 1.w;
  static final double _fontSize = 4.w;

  final String? value;
  final KeysSaveScreenService service;
  final Function() onPressed;

  KeysNewScreenDialogCopyButton(this.value, this.service, this.onPressed);

  @override
  Widget build(BuildContext context) {
    var saved = this.value!.contains("@")
        ? service.model.savedEmail
        : service.model.savedKeys;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ConfigColor.white,
          border: Border.all(
            color: ConfigColor.silverChalice,
          ),
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
      child: Row(
        children: [_text(), _button(saved)],
      ),
    );
  }

  Widget _text() {
    return Expanded(
        child: Container(
            padding: EdgeInsets.only(left: 8),
            child: Text(value!,
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left)));
  }

  Widget _button(bool saved) {
    return Container(
        decoration: BoxDecoration(
            border: Border(left: BorderSide(color: ConfigColor.silverChalice))),
        child: Container(
            decoration: BoxDecoration(
              color: ConfigColor.gallery,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius)),
            ),
            child: TextButton(
                onPressed: onPressed,
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: _paddingHorizontal),
                        child: Row(
                          children: [
                            Text(_buttonText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: _fontSize,
                                    color: saved
                                        ? ConfigColor.jade
                                        : ConfigColor.mardiGras)),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: _paddingHorizontalIcon),
                                child: Container(
                                    width: 4.w,
                                    child: saved
                                        ? Image(
                                            image: AssetImage(
                                                "res/images/icon-check.png"))
                                        : Image(
                                            image: AssetImage(
                                                "res/images/icon-copy.png"))))
                          ],
                        ))))));
  }
}
