/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class UserAccountModalViewProfileAvatar extends StatelessWidget {
  static const num _labelWidth = 26.5;

  final String label;
  final String avatar;

  UserAccountModalViewProfileAvatar(
      {required this.label, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: AssetImage('res/images/' + avatar + '.png'),
          height: 10.h,
          fit: BoxFit.fitHeight,
        ),
        Stack(alignment: AlignmentDirectional.center, children: [
          Image(
            image: AssetImage('res/images/badge-account.png'),
            width: _labelWidth.w,
            fit: BoxFit.fitWidth,
          ),
          Container(
              width: _labelWidth.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: ConfigColor.white,
                        fontSize: 8.sp),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 1.w),
                      child: Image(
                        image: AssetImage('res/images/icon-star.png'),
                        height: 8.sp,
                        fit: BoxFit.fitHeight,
                      )),
                ],
              ))
        ])
      ],
    );
  }
}
