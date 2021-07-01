/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class InfoCarouselCardViewScrollCtaHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "What can you do about it?",
      style: TextStyle(
          color: ConfigColor.tikiBlue,
          fontWeight: FontWeight.w800,
          fontSize: 13.sp,
          fontFamily: "NunitoSans"),
    );
  }
}
