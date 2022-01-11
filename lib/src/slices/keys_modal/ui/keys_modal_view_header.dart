/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import '../keys_modal_service.dart';

class KeysModalViewHeader extends StatelessWidget {
  static const num _paddingHoriz = 6;
  static const num _paddingVert = 3;

  @override
  Widget build(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context);
    return Stack(children: [
      // GestureDetector(
      //     behavior: HitTestBehavior.opaque,
      //     onTap: () => Navigator.of(context).pop(),
      //     child: Container(
      //         alignment: Alignment.centerRight,
      //         child: Container(
      //             width: _paddingHoriz.w * 3,
      //             height: _paddingVert.h * 3,
      //             padding: EdgeInsets.only(right: _paddingHoriz.w),
      //             child: Center(
      //                 child: HelperImage(
      //               "icon-x",
      //               width: 15.sp,
      //               height: 15.sp,
      //             ))))),
      // GestureDetector(
      //       behavior: HitTestBehavior.opaque,
      //       onTap: () => service.controller.navigateBack(context),
      //       child: Container(
      //           alignment: Alignment.centerLeft,
      //           width: _paddingHoriz.w * 3,
      //           child: Container(
      //               width: _paddingHoriz.w * 3,
      //               height: _paddingVert.h * 3,
      //               padding: EdgeInsets.only(right: _paddingHoriz.w),
      //               child: Center(
      //                   child: HelperImage(
      //                 "icon-back",
      //                 width: 20.sp,
      //                 height: 20.sp,
      //               ))))),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: _paddingVert.h,
          ),
          child: Text(service.model.title,
              style: TextStyle(
                  color: ConfigColor.tikiPurple,
                  fontWeight: FontWeight.w800,
                  fontFamily: ConfigFont.familyNunitoSans,
                  fontSize: 13.sp))),
    ]);
  }
}
