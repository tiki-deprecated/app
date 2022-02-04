/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class DataScreenViewSoonIcon extends StatelessWidget {
  final String image;
  final String label;

  DataScreenViewSoonIcon({required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 16.w,
        child: Column(
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
        ));
  }
}
