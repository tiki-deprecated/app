/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeysNewScreenSaveCopyButton extends StatelessWidget {
  static const String _buttonText = "COPY";
  static final double _borderRadius = 2 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingLeft = 2 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingHorizontal =
      2 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingHorizontalIcon =
      1 * PlatformRelativeSize.blockHorizontal;

  final String label;
  final String? value;

  KeysNewScreenSaveCopyButton(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ConfigColor.white,
          border: Border.all(
            color: ConfigColor.silverChalice,
          ),
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: _paddingLeft),
            child: Text(label + " : ", textAlign: TextAlign.left),
          ),
          Flexible(child:Container(
                  child: Text(value!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left)
          )),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: ConfigColor.silverChalice))),
              child: Container(
                  decoration: BoxDecoration(
                    color: ConfigColor.gallery,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(_borderRadius),
                        bottomRight: Radius.circular(_borderRadius)),
                  ),
                  child: TextButton(
                      onPressed: () {
                        Clipboard.setData(new ClipboardData(text: value));
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _paddingHorizontal),
                              child: Row(
                                children: [
                                  Text(_buttonText),
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: _paddingHorizontalIcon),
                                      child: Image(
                                          image: AssetImage(
                                              "res/images/icon-copy.png"),
                                          color: IconTheme.of(context).color))
                                ],
                              ))))))
        ],
      ),
    );
  }
}
