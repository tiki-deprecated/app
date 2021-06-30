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

class InfoCarouselCardViewCoverHeader extends StatelessWidget {
  final Animation<double> _animationValue;

  InfoCarouselCardViewCoverHeader(this._animationValue);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCarouselCardService>(context);
    var model = service.model.cover!.header!;
    return Opacity(
        opacity: 1 - _animationValue.value,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child: Row(children: [
            HelperImage(model.image!, width: 6.w),
            Padding(padding: EdgeInsets.only(right: 2.w)),
            Text(
              model.title!,
              style: TextStyle(
                  fontFamily: "NunitoSans",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: ConfigColor.tikiBlue),
            )
          ])),
          GestureDetector(
              onTap: () => service.controller
                  .shareCard(context, model.title!, model.image!),
              child: Icon(Icons.share, color: ConfigColor.orange, size: 36.sp))
        ]));
  }
}
