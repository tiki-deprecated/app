import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TikiCardTitle extends StatelessWidget {
  final String? title;
  final Color? textColor;

  const TikiCardTitle(this.title, {this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(title ?? "",
        style: TextStyle(
            color: textColor ?? ConfigColor.mardiGras,
            fontSize: 6.w,
            fontWeight: FontWeight.w800,
            fontFamily: "NunitoSans"));
  }
}
