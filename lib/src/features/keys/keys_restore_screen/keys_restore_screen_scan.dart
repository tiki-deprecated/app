/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_restore_screen/keys_restore_screen_bloc.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeysRestoreScreenScan extends StatelessWidget {
  static const String _text = "SCAN";
  static final double _letterSpacing =
      0.05 * PlatformRelativeSize.blockHorizontal;
  static final double _fontSize = 6 * PlatformRelativeSize.blockHorizontal;
  static final double _marginHorizontal =
      10 * PlatformRelativeSize.blockHorizontal;
  static final double _marginVertical =
      2.5 * PlatformRelativeSize.blockVertical;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(10 * PlatformRelativeSize.blockVertical))),
            primary: ConfigColor.mardiGras),
        child: Container(
            margin: EdgeInsets.symmetric(
                vertical: _marginVertical, horizontal: _marginHorizontal),
            child: Row(children: [
              Expanded(
                  child: Text(_text,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: _fontSize,
                        letterSpacing: _letterSpacing,
                      ))),
              Align(
                  alignment: Alignment.centerRight,
                  child: HelperImage("icon-qr-code"))
            ])),
        onPressed: () {
          BlocProvider.of<KeysRestoreScreenBloc>(context)
              .add(KeysRestoreScreenScanned());
        });
  }
}
