/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../info_carousel_card_service.dart';

class InfoCarouselCardViewScrollHeader extends StatelessWidget {
  final Animation<double> _animationValue;

  InfoCarouselCardViewScrollHeader(this._animationValue);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCarouselCardService>(context);
    var model = service.model.cover!;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
          width: 42.w,
          child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                  style: TextStyle(
                      color: ConfigColor.blue,
                      fontFamily: "Koara",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                  text: model.bigTextLight!,
                  children: [
                    TextSpan(
                        text: model.bigTextDark!,
                        style: TextStyle(
                            color: ConfigColor.tikiBlue,
                            fontFamily: "Koara",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold))
                  ]))),
      HelperImage(model.image!,
          width: service.controller.calculateAnimation(
              MediaQuery.of(context).size.width, _animationValue.value, 18.h)),
    ]);
  }
}
