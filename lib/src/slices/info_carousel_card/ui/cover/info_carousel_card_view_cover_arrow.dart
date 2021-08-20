/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/helper_image.dart';
import '../../info_carousel_card_controller.dart';
import '../../info_carousel_card_service.dart';

class InfoCarouselCardViewCoverArrow extends StatelessWidget {
  final Animation<double> _animationValue;
  final Animation _animationController;

  InfoCarouselCardViewCoverArrow(
      this._animationController, this._animationValue);

  @override
  Widget build(BuildContext context) {
    InfoCarouselCardController controller =
        Provider.of<InfoCarouselCardService>(context).controller;
    return GestureDetector(
        onTap: () => controller.tapArrowSlideUp(_animationController),
        child: Opacity(
            opacity: this._animationValue.value * 2 <= 1
                ? 1 - (this._animationValue.value * 2)
                : 0,
            child: HelperImage(
              "arrow-up",
              width: 14.5.w,
            )));
  }
}
