/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/info_carousel_card/ui/cover/info_carousel_card_layout_cover.dart';
import 'package:flutter/material.dart';

import 'scroll/info_carousel_card_layout_scroll.dart';

class InfoCarouselCardLayoutSwipe extends AnimatedWidget {
  final animationController;

  InfoCarouselCardLayoutSwipe(
      {Key? key, required AnimationController this.animationController})
      : super(key: key, listenable: animationController);

  Animation<double> get _animationValue => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return _animationValue.value < 1.0
        ? InfoCarouselCardLayoutCover(_animationValue)
        : InfoCarouselCardLayoutScroll(_animationValue);
  }
}
