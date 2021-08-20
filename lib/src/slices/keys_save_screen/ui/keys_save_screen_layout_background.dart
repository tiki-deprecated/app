import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';

class KeysNewScreenLayoutBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: ConfigColor.cream)),
      Align(
          alignment: Alignment.topRight,
          child: HelperImage(
            "keys-blob",
            width: 41.w,
          ))
    ]);
  }
}
