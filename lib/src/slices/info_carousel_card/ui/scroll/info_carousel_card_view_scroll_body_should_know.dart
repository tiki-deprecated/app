/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/helper_image.dart';
import '../../info_carousel_card_service.dart';
import '../../model/info_carousel_card_model_content_icon.dart';

class InfoCarouselCardViewScrollBodyShouldKnow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCarouselCardService>(context);
    List<InfoCarouselCardModelContentIcon> shouldKnowData =
        service.model.content!.body!.shouldKnow!;
    List<Widget> shouldKnow = [];
    for (int i = 0; i < shouldKnowData.length; i++) {
      if (i > 0)
        shouldKnow.add(Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Divider(
              color: Colors.white,
            )));
      shouldKnow.add(Row(children: [
        Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: HelperImage(shouldKnowData[i].image!, width: 7.w)),
        Expanded(
          child: Text(shouldKnowData[i].text!,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: "NunitoSans",
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        )
      ]));
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              child: HelperImage(
            "information",
            width: 7.w,
          )),
          Container(
            margin: EdgeInsets.only(top: 2.h, bottom: 1.h),
            child: Text("You should know",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "NunitoSans",
                    fontWeight: FontWeight.w800,
                    fontSize: 13.sp)),
          ),
          ...shouldKnow
        ]));
  }
}
