/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'info_carousel_card_layout_swipe.dart';

class InfoCarouselCardLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoCarouselCardLayout();
}

class _InfoCarouselCardLayout extends State<InfoCarouselCardLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3.h)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 1.w,
                  offset: Offset(0, 0.5.h), // Shadow position
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(3.h)),
                child: InfoCarouselCardLayoutSwipe(_animationController))));
  }
}
