import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/material.dart';

/// The default text button for Tiki.
class TikiTextButton extends StatelessWidget {
  final String text;
  final Function callback;
  final int fontSize;
  final Map<String, int> margins;
  final Map<String, int> padding;
  final FontWeight fontWeight;
  final Color color;
  final Color backgroundColor;
  final bool isActive;
  final Widget leading;
  final Widget trailing;

  const TikiTextButton(this.text, this.callback,
      {this.fontSize = 1,
      this.margins = const {"left": 0, "top": 0, "right": 0, "bottom": 0},
      this.padding = const {"left": 0, "top": 0, "right": 0, "bottom": 0},
      this.fontWeight = FontWeight.normal,
      this.color = ConfigColor.black,
      this.backgroundColor = Colors.transparent,
      this.isActive = true,
      this.trailing,
      this.leading
      });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: _getMargins(),
        padding: _getPadding(),
        color: backgroundColor,
        child: TextButton(
        onPressed: isActive ? () => callback(context) : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading ?? Container(),
            Text(this.text,
                style: TextStyle(
                    color: this.color,
                    fontWeight: this.fontWeight,
                    fontSize: PlatformRelativeSize.blockHorizontal * fontSize)),
            trailing ?? Container(),
          ],
        )
    ));
  }

  _getMargins() {
    return EdgeInsets.fromLTRB(
        margins['left'] * PlatformRelativeSize.blockHorizontal,
        margins['top'] * PlatformRelativeSize.blockVertical,
        margins['right'] * PlatformRelativeSize.blockHorizontal,
        margins['bottom'] * PlatformRelativeSize.blockVertical);
  }

  _getPadding() {
    return EdgeInsets.fromLTRB(
        padding['left'] * PlatformRelativeSize.blockHorizontal,
        padding['top'] * PlatformRelativeSize.blockVertical,
        padding['right'] * PlatformRelativeSize.blockHorizontal,
        padding['bottom'] * PlatformRelativeSize.blockVertical);
  }
}
