import 'package:flutter/material.dart';

class TikiCardText extends StatelessWidget {
  final String text;

  const TikiCardText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
