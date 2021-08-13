/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class UserAccountModalViewBadgesSelect extends StatelessWidget {
  final bool isSelected;
  final String image;
  final String label;

  UserAccountModalViewBadgesSelect(
      {required this.image, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Koara",
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
              color: isSelected ? ConfigColor.tikiBlue : ConfigColor.greyFive),
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: [
                BoxShadow(
                  color: Color(0x08000000),
                  blurRadius: 0.75.w,
                  offset: Offset(-0.5.w, 0.75.w), // Shadow position
                ),
              ],
            ),
            padding: EdgeInsets.only(top: 0.5.h),
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Image(
                  image: AssetImage(isSelected
                      ? 'res/images/' + image + '-active.png'
                      : 'res/images/' + image + '-inactive.png'),
                  width: 15.w,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ))
      ],
    );
  }
}
