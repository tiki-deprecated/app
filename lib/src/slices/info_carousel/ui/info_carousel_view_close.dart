import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class InfoCarouselViewClose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('CLOSE',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: ConfigColor.tikiPurple,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.w800)),
          Padding(
              padding: EdgeInsets.only(left: 0.5.w),
              child: Icon(Icons.close,
                  size: 22.sp, color: ConfigColor.tikiPurple)),
        ]),
        onTap: () => Navigator.of(context).pop());
  }
}
