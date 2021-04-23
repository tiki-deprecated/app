/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/config/config_color.dart';
import 'package:app_stash/src/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiBigButton extends StatelessWidget {
  static final double _letterSpacing =
      0.05 * PlatformRelativeSize.blockHorizontal;
  static final double _fontSize = 6 * PlatformRelativeSize.blockHorizontal;
  static final double _marginHorizontal =
      10 * PlatformRelativeSize.blockHorizontal;
  static final double _marginVertical =
      2.5 * PlatformRelativeSize.blockVertical;

  final String text;
  final void Function(BuildContext context) onPressed;
  final double fixedWidth;
  UiBigButton(this.text, this.onPressed, {this.fixedWidth});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(10 * PlatformRelativeSize.blockVertical))),
            primary: ConfigColor.mardiGras),
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: _marginVertical,
                    horizontal: fixedWidth != null ? 0 : _marginHorizontal),
                width: fixedWidth != null ? fixedWidth : null,
                child: Center(
                    child: Text(text,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: _fontSize,
                          letterSpacing: _letterSpacing,
                        ))))
          ],
        ),
        onPressed: () => onPressed(context));
  }
}
