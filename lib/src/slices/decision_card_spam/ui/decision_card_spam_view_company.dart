import 'dart:math';

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewCompany extends StatelessWidget {
  final logo;
  final name;
  final email;

  const DecisionCardSpamViewCompany(
      {Key? key, this.logo, this.name, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getAvatar(this.logo, this.name, this.email),
            Padding(padding: EdgeInsets.only(top: 1.h)),
            _getCompanyName(this.name, this.email)
          ],
        ));
  }

  Widget _getAvatar(logo, name, email) {
    if (logo != null) {
      return ClipOval(child: Image.network(logo, height: 8.h));
    } else {
      var img = 'avatar' + (Random().nextInt(2) + 1).toString();
      String title = name ?? email;
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: ConfigColor.greyTwo, width: 5),
            boxShadow: [
              BoxShadow(
                  color: Color(0x4D000000),
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                  blurRadius: 12)
            ],
          ),
          child: ClipOval(
              child: Container(
                  width: 8.h,
                  height: 8.h,
                  child: Stack(children: [
                    HelperImage(img, height: 8.h),
                    Center(
                      child: Text(title[0].toUpperCase(),
                          style: TextStyle(color: ConfigColor.tikiBlue)),
                    )
                  ]))));
    }
  }

  _getCompanyName(name, email) {
    if (name != null) {
      return Text(name,
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "nunitoSans"));
    } else {
      return Text(email,
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "nunitoSans"));
    }
  }
}
