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

  const InfoCarouselCardViewCoverArrow(
      this._animationController, this._animationValue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InfoCarouselCardService service =
        Provider.of<InfoCarouselCardService>(context);
    if (service.model.content?.body == null) return Container();
    InfoCarouselCardController controller = service.controller;
    return GestureDetector(
        onTap: () => controller.tapArrowSlideUp(_animationController),
        child: Opacity(
            opacity: _animationValue.value * 2 <= 1
                ? 1 - (_animationValue.value * 2)
                : 0,
            child: HelperImage(
              "arrow-up",
              width: 14.5.w,
            )));
  }
}
