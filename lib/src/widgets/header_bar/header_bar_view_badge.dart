/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class HeaderBarViewBadge extends StatelessWidget {
  static const _width = 28;

  final String label;

  HeaderBarViewBadge(this.label);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      Image(
        image: AssetImage('res/images/badge-header.png'),
        width: _width.w,
        fit: BoxFit.fitWidth,
      ),
      Container(
          width: _width.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                label,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: ConfigColor.white,
                    fontSize: 10.81.sp),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Image(
                    image: AssetImage('res/images/icon-star.png'),
                    height: 10.81.sp,
                    fit: BoxFit.fitHeight,
                  )),
            ],
          ))
    ]);
  }
}
