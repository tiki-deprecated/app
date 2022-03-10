/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/config_color.dart';
import '../../../../utils/helper_image.dart';
import '../../info_carousel_card_service.dart';
import '../../model/info_carousel_card_model_content_icon.dart';

class InfoCarouselCardViewScrollBodyTheySay extends StatelessWidget {

  const InfoCarouselCardViewScrollBodyTheySay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCarouselCardService>(context);
    List<InfoCarouselCardModelContentIcon> theySayData =
        service.model.content!.body!.theySay!;
    List<Widget> theySay = [];
    for (int i = 0; i < theySayData.length; i++) {
      if (i > 0) {
        theySay.add(Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: const Divider(
              color: Colors.white,
            )));
      }
      theySay.add(Row(children: [
        Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: HelperImage(theySayData[i].image!, width: 7.w)),
        Expanded(
          child: Text(theySayData[i].text!,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: "NunitoSans",
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        )
      ]));
    }
    return Container(
        color: ConfigColor.tikiBlack,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.only(bottom: 2.h),
              width: double.maxFinite,
              child: Text("What Google says it needs it for:",
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "NunitoSans",
                      color: Colors.white,
                      fontWeight: FontWeight.w800))),
          ...theySay
        ]));
  }
}
