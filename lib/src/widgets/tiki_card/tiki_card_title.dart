import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/material.dart';

class TikiCardTitle extends StatelessWidget {
  final String? title;
  final Color? textColor;

  const TikiCardTitle(this.title, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Text(title ?? "",
    style: TextStyle(
      color: textColor ?? Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w800,
      fontFamily: "NunitoSans"
    ));
  }
}
