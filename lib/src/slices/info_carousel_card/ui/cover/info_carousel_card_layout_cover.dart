/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../info_carousel_card_service.dart';
import 'info_carousel_card_view_cover_arrow.dart';
import 'info_carousel_card_view_cover_big_text.dart';
import 'info_carousel_card_view_cover_header.dart';
import 'info_carousel_card_view_cover_image.dart';
import 'info_carousel_card_view_cover_subtitle.dart';
import 'info_carousel_card_view_cover_text.dart';

class InfoCarouselCardLayoutCover extends StatelessWidget {
  final Animation<double> _animationValue;

  InfoCarouselCardLayoutCover(this._animationValue);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCarouselCardService>(context);
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 4.w, top: 1.h, right: 4.w),
        child: Container(
            child: Column(
          children: [
            SizedBox(
                width: double.infinity,
                child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    textDirection: TextDirection.rtl,
                    children: [
                      if (_animationValue.value < 1.0)
                        InfoCarouselCardViewCoverHeader(_animationValue),
                      InfoCarouselCardViewCoverImage(_animationValue),
                      if (_animationValue.value < 1.0)
                        Align(
                            alignment: Alignment.topLeft,
                            child: InfoCarouselCardViewCoverSubtitle(
                                _animationValue)),
                      Container(
                          padding: EdgeInsets.only(top: 1.25.h),
                          width: service.controller.calculateAnimation(
                              MediaQuery.of(context).size.width,
                              _animationValue.value,
                              42.w),
                          child: InfoCarouselCardViewCoverBigText(
                              _animationValue)),
                    ])),
            Container(
                padding: EdgeInsets.only(top: 1.25.h),
                child: InfoCarouselCardViewCoverText(_animationValue)),
            Expanded(
                child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: InfoCarouselCardViewCoverArrow(_animationValue)))
          ],
        )));
  }
}
