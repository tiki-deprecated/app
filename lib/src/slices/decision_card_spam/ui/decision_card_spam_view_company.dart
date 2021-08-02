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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _getAvatar(this.logo, this.name, this.email),
        _getCompanyName(this.name, this.email)
      ],
    );
  }

  _getAvatar(logo, name, email) {
    if (logo != null) {
      return ClipOval(
          child: Container(
              decoration: BoxDecoration(
                color: ConfigColor.greyTwo,
              ),
              height: 8.h,
              child: Center(child: Image.network(logo, height: 8.h))));
    } else {
      var img = 'avatar' + (Random().nextInt(2) + 1).toString();
      String title = name ?? email;
      return Stack(children: [
        HelperImage(img, height: 8.h),
        Text(title[0].toUpperCase())
      ]);
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
