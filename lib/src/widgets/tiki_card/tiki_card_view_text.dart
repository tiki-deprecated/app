import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TikiCardViewText extends StatelessWidget {
  final String text;

  const TikiCardViewText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600));
  }
}
