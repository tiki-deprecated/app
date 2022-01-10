/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';
import '../md_screen_service.dart';

class MdScreenViewBackButton extends StatelessWidget {
  static const num _marginBackArrowRight = 1;
  static const num _fontSizeBack = 15;
  static const String _textBack = "Back";

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Provider.of<MdScreenService>(context, listen: false)
          .controller
          .back(context),
      child: Row(children: [
        Container(
          child: HelperImage('back-arrow', height: _fontSizeBack.sp),
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
