import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import '../../../utils/helper_image.dart';
import '../../security_score_modal/security_score_modal_service.dart';

class DecisionCardSpamViewSecurity extends StatelessWidget {
  final double? security;
  final double? sensitivity;
  final double? hacking;

  DecisionCardSpamViewSecurity(
      {double? security, this.sensitivity, this.hacking})
      : this.security = security != null ? (1 - security) * 5 : null;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: _getStars()),
      Padding(
        padding: EdgeInsets.only(top: 1.h),
      ),
      this.security != null
          ? RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: ConfigFont.familyKoara,
                      color: ConfigColor.greyFive,
                      fontSize: 15.sp),
                  text: "Your data is ",
                  children: [
                    TextSpan(
                        text: _getSecurityText(this.security ?? 0),
                        style: TextStyle(color: _getColorForText())),
                    _getInfoIcon(context)
                  ]),
            )
          : RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: ConfigFont.familyKoara,
                      color: ConfigColor.greyFive,
                      fontSize: 15.sp),
                  text: "No data score info yet",
                  children: [_getInfoIcon(context)]),
            ),
    ]));
  }

  List<Widget> _getStars() {
    var color = _getColor();
    var starRate = this.security ?? 0;
    var stars = <Widget>[];
    for (int i = 0; i < 5; i++) {
      if (i >= starRate.floor() && i < starRate.ceil()) {
        stars.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Stack(children: [
              HelperImage("star-grey", width: 6.w),
              ClipRect(
                child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.5,
                    child: HelperImage("star-$color", width: 6.w)),
              ),
            ])));
      } else if (i >= starRate.ceil())
        stars.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.75.w),
            child: HelperImage("star-grey", width: 6.w)));
      else
        stars.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.75.w),
            child: HelperImage("star-$color", width: 6.w)));
    }
    return stars;
  }

  String _getColor() {
    if (this.security == null) {
      return "grey";
    } else {
      var starRate = this.security ?? 0;
      if (starRate < 2) {
        return "red";
      } else if (starRate < 4) {
        return "yellow";
      } else {
        return "green";
      }
    }
  }

  Color _getColorForText() {
    var starRates = this.security ?? 0;
    if (this.security == null) {
      return ConfigColor.greySix;
    } else {
      if (starRates < 2) {
        return ConfigColor.tikiRed;
      } else if (starRates < 4) {
        return ConfigColor.tikiOrange;
      } else {
        return ConfigColor.green;
      }
    }
  }

  String _getSecurityText(num starRate) {
    if (starRate < 2) {
      return "not safe";
    } else if (starRate < 4) {
      return "somewhat safe";
    } else {
      return "very safe";
    }
  }

  _getInfoIcon(BuildContext context) {
    return WidgetSpan(
        child: Padding(
            padding: EdgeInsets.only(
              left: 1.5.w,
            ),
            child: GestureDetector(
                child: Icon(
                  Icons.info_outline_rounded,
                  color: ConfigColor.greyFive,
                  size: 17.sp,
                ),
                onTap: () => SecurityScoreModalService(
                        hacking: this.hacking,
                        sensitivity: this.sensitivity,
                        security: this.security)
                    .presenter
                    .showModal(context))));
  }
}
