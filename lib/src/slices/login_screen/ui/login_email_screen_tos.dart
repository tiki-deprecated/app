/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/md_viewer/md_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginEmailScreenTos extends StatelessWidget {
  static final double _fontSize = 2.h;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text("By pressing \"Continue\" you agree to TIKI's ",
            style: _textStyle()),
        _link(
            "Terms of Service",
            () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MdViewer("TERMS")))),
        Text(" and ", style: _textStyle()),
        _link(
            "Privacy Policy",
            () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MdViewer("PRIVACY")))),
      ],
    );
  }

  TextStyle _textStyle({Color color = ConfigColor.boulder}) {
    return TextStyle(
        fontSize: _fontSize, fontWeight: FontWeight.bold, color: color);
  }

  Widget _link(String text, Function() onPressed) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 0,
      height: _fontSize,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(0),
      child: Text(text, style: _textStyle(color: ConfigColor.orange)),
    );
  }
}
