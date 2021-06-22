import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class TikiCardText extends StatelessWidget {
  final String text;

  const TikiCardText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 4.w));
  }
}
