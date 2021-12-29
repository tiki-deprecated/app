/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class DataScreenViewScore extends StatelessWidget {
  static const String _title = "Your data";

  final String image;
  final String summary;
  final String description;
  final Color color;

  DataScreenViewScore(
      {required this.image,
      required this.summary,
      required this.description,
      this.color = ConfigColor.blue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _title,
          style: TextStyle(
              fontFamily: "Koara",
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
              color: ConfigColor.tikiBlue),
        ),
        Container(
            margin: EdgeInsets.only(top: 1.h),
            child: Image(
              image: AssetImage('res/images/' + image + '.png'),
              height: 17.h,
              fit: BoxFit.fitHeight,
            )),
        Container(
            margin: EdgeInsets.only(top: 1.h),
            child: Text(
              summary,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Koara",
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: color),
            )),
        Container(
            margin: EdgeInsets.only(top: 0.75.h),
            child: Text(description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ConfigColor.tikiBlue,
                    fontSize: 11.sp))),
      ],
    );
  }
}
