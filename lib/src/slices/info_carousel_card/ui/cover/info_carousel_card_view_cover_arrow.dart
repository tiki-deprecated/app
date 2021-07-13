/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoCarouselCardViewCoverArrow extends StatelessWidget {
  final Animation<double> _animationValue;

  InfoCarouselCardViewCoverArrow(this._animationValue);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: this._animationValue.value * 2 <= 1
            ? 1 - (this._animationValue.value * 2)
            : 0,
        child: HelperImage(
          "arrow-up",
          width: 14.5.w,
        ));
  }
}
