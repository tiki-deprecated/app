/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tiki_kv/tiki_kv.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import '../../../utils/helper_image.dart';
import '../../home_screen/home_screen_controller.dart';
import '../home_screen_service.dart';

class HomeScreenViewOverlay extends StatelessWidget {
  const HomeScreenViewOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller =
        Provider.of<HomeScreenService>(context, listen: false).controller;
    return GestureDetector(
        onTap: () async => controller
            .dismissOverlay(Provider.of<TikiKv>(context, listen: false)),
        child: Stack(children: [
          Image(
            image: const AssetImage('res/images/overlay-bg.png'),
            width: 100.w,
            fit: BoxFit.cover,
          ),
          _content()
        ]));
  }

  Widget _content() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.only(top: 20.h),
          child: HelperImage("swipe-choices", width: 100.w)),
      Container(
          margin: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Unsubscribe from an email ',
                  style: TextStyle(
                      color: ConfigColor.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: ConfigFont.familyNunitoSans,
                      fontSize: 12.sp),
                  children: const [
                    TextSpan(
                        text: 'list by swiping left, or\n',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: 'keep their emails coming ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'by swiping right.',
                        style: TextStyle(fontWeight: FontWeight.w600))
                  ]))),
      Container(
          margin: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Unsubscribing will remove you from an email list.\n',
                  style: TextStyle(
                      color: ConfigColor.tikiOrange,
                      fontWeight: FontWeight.w600,
                      fontFamily: ConfigFont.familyNunitoSans,
                      fontSize: 12.sp),
                  children: const [
                    TextSpan(
                        text:
                            'You can always re-subscribe by going back to their website.',
                        style: TextStyle(color: ConfigColor.white))
                  ])))
    ]);
  }
}
