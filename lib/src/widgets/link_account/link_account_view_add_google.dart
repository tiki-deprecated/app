import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'link_account_view_add.dart';

class LinkAccountViewAddGoogle extends StatelessWidget
    implements LinkAccountViewAdd {
  static const double _scale = 0.9;

  final String text;
  final String icon;
  final Function()? onLink;

  LinkAccountViewAddGoogle(
      {required this.text, required this.icon, this.onLink});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onLink, // controller.onLink(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.sp * _scale),
          height: 40.sp * _scale,
          decoration: BoxDecoration(
            color: ConfigColor.white,
            borderRadius: BorderRadius.circular(5.sp * _scale),
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
              height: 18.sp * _scale,
              fit: BoxFit.fitHeight,
            ),
            Container(
                margin: EdgeInsets.only(left: 24.sp * _scale),
                child: Text(text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14.sp * _scale,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        color: Colors.black54))),
          ]),
        ));
  }
}
