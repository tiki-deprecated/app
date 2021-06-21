import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/material.dart';

class TikiCardText extends StatelessWidget {
  final String text;

  const TikiCardText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 4 * PlatformRelativeSize.blockHorizontal));
  }
}
