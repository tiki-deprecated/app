/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/keys_restore_screen/keys_restore_screen_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class KeysRestoreScreenViewBack extends StatelessWidget {
  static const num _marginBackArrowRight = 1;
  static const num _fontSizeBack = 15;
  static const String _textBack = "Back";

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () =>
          Provider.of<KeysRestoreScreenService>(context, listen: false)
              .controller
              .back(context),
      child: Row(children: [
        Container(
          child: HelperImage(
            'back-arrow',
            height: _fontSizeBack.sp,
          ),
          margin: EdgeInsets.only(right: _marginBackArrowRight.w),
        ),
        Text(_textBack,
            style: TextStyle(
                color: ConfigColor.orange,
                fontWeight: FontWeight.w800,
                fontSize: _fontSizeBack.sp))
      ]),
    );
  }
}
