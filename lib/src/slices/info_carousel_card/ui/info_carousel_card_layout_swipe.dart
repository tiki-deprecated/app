/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/info_carousel_card/ui/cover/info_carousel_card_layout_cover.dart';
import 'package:app/src/slices/info_carousel_card/ui/scroll/info_carousel_card_layout_scroll.dart';
import 'package:flutter/material.dart';

class InfoCarouselCardLayoutSwipe extends AnimatedWidget {
  final AnimationController _animationController;

  InfoCarouselCardLayoutSwipe(this._animationController, {Key? key})
      : super(key: key, listenable: _animationController);

  Animation<double> get _animationValue => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return _animationValue.value < 1.0
        ? InfoCarouselCardLayoutCover(_animationValue, _animationController)
        : InfoCarouselCardLayoutScroll(_animationValue, _animationController);
  }
}
