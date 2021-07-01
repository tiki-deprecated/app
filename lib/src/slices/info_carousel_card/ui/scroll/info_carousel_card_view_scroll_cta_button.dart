/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../info_carousel_card_service.dart';

class InfoCarouselCardViewScrollCtaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCarouselCardService>(context);
    var model = service.model.content!.cta!;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(70.w),
          primary: ConfigColor.orange,
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
        ),
        child: Text(model.buttonText!,
            style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w800)),
        onPressed: () => service.controller.openUrl(model.buttonUrl));
    ;
  }
}
