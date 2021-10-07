import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'link_account_view_add.dart';

class LinkAccountViewAddMicrosoft extends StatelessWidget
    implements LinkAccountViewAdd {
  static const double _scale = 0.8;

  final String text;
  final String icon;
  final Function()? onLink;

  LinkAccountViewAddMicrosoft(
      {required this.text, required this.icon, this.onLink});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onLink, // controller.onLink(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.sp * _scale),
          height: 41.sp * _scale,
          decoration: BoxDecoration(
            color: ConfigColor.white,
            border: Border.all(color: Color(0xFF8C8C8C), width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2.w,
                offset: Offset(0.75.w, 0.75.w), // Shadow position
              ),
            ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Image(
              image: AssetImage('res/images/' + icon + '.png'),
              height: 22.sp * _scale,
              fit: BoxFit.fitHeight,
            ),
            Container(
                margin: EdgeInsets.only(left: 12.sp * _scale),
                child: Text(text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15.sp * _scale,
                        fontFamily: "Segoe",
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5E5E5E)))),
          ]),
        ));
  }
}
