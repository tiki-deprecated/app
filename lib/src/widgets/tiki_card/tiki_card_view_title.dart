import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';

class TikiCardViewTitle extends StatelessWidget {
  final String? title;
  final Color? textColor;

  const TikiCardViewTitle(this.title, {this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(title ?? "",
        style: TextStyle(
            color: textColor ?? ConfigColor.tikiPurple,
            fontSize: 14.sp,
            fontWeight: FontWeight.w800));
  }
}
