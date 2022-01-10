import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';

class SupportModalViewBoxTitle extends StatelessWidget {
  final dynamic data;

  const SupportModalViewBoxTitle(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Text(data.title ?? "",
            style: TextStyle(
                color: ConfigColor.tikiPurple,
                fontSize: 20.sp,
                fontFamily: ConfigFont.familyNunitoSans,
                fontWeight: FontWeight.w700)));
  }
}
