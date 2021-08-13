import 'dart:math';

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewCompany extends StatelessWidget {
  final String? logo;
  final String? name;
  final String? email;

  const DecisionCardSpamViewCompany(
      {Key? key, this.logo, this.name, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _getAvatar(this.logo, this.name, this.email),
        Padding(padding: EdgeInsets.only(top: 1.h)),
        _getCompanyName(this.name, this.email)
      ],
    );
  }

  Widget _getAvatar(String? logo, String? name, String? email) {
    return Container(
        height: 10.h,
        width: 10.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: ConfigColor.greyThree, width: 4.5.sp),
          color: ConfigColor.white,
          boxShadow: [
            BoxShadow(
                color: Color(0x26000000),
                offset: Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 12)
          ],
        ),
        child: ClipOval(
            child: logo != null
                ? Image.network(logo,
                    height: 10.h,
                    errorBuilder: (context, error, stackTrace) =>
                        _randomAvatar())
                : _randomAvatar()));
  }

  Widget _randomAvatar() {
    String img = 'avatar' + (Random().nextInt(3) + 1).toString();
    String title = name ?? email ?? "";
    return Stack(children: [
      Image(
        image: AssetImage('res/images/' + img + '.png'),
        width: 10.h,
        height: 10.h,
        fit: BoxFit.fill,
      ),
      Center(
        child: Text(title[0].toUpperCase(),
            style: TextStyle(
                color: ConfigColor.tikiBlue,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                fontFamily: ConfigFont.familyNunitoSans)),
      )
    ]);
  }

  _getCompanyName(name, email) {
    if (name != null) {
      return Text(name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              fontFamily: ConfigFont.familyNunitoSans));
    } else {
      return Text(email,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              fontFamily: ConfigFont.familyNunitoSans));
    }
  }
}
