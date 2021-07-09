/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class DataScreenViewSoonIcon extends StatelessWidget {
  final String image;
  final String label;

  DataScreenViewSoonIcon({required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('res/images/' + image + '.png'),
          height: 5.5.h,
          fit: BoxFit.fitHeight,
        ),
        Container(
            margin: EdgeInsets.only(top: 0.5.h),
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 9.sp,
                  color: ConfigColor.tikiBlue),
            )),
      ],
    );
  }
}
