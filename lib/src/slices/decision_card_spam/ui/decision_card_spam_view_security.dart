import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewSecurity extends StatelessWidget {
  final double starRates;

  const DecisionCardSpamViewSecurity(this.starRates);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Column(children: [DecisionCardSpamViewSecurityStars(this.starRates)]),
    );
  }
}

class DecisionCardSpamViewSecurityStars extends StatelessWidget {
  final double starRates;

  DecisionCardSpamViewSecurityStars(this.starRates);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 3.h),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: _getStars()),
      Padding(
        padding: EdgeInsets.only(top: 3.h),
      ),
      RichText(
        text: TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: ConfigFont.familyKoara,
                color: ConfigColor.greyFour,
                fontSize: 22.sp),
            text: "Your data is ",
            children: [
              TextSpan(
                  text: _getSecurityText(),
                  style: TextStyle(color: _getColorForText()))
            ]),
      ),
      Padding(
        padding: EdgeInsets.only(top: 3.h),
      ),
    ]);
  }

  List<Widget> _getStars() {
    var color = _getColor();
    var stars = <Widget>[];
    for (int i = 0; i < 5; i++) {
      if (i < this.starRates) {
        stars.add(HelperImage("star-$color", width: 6.w));
      } else if (i > this.starRates.floor() && i < this.starRates.ceil()) {
        stars.add(Stack(children: [
          ClipRect(
            child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: 0.5,
                child: HelperImage("star-$color", width: 7.w)),
          ),
          HelperImage("star-grey", width: 7.w),
        ]));
      } else if (i >= this.starRates) {
        stars.add(HelperImage("star-grey", width: 7.w));
      }
    }
    return stars;
  }

  String _getColor() {
    if (this.starRates < 2) {
      return "red";
    } else if (this.starRates < 4) {
      return "yellow";
    } else {
      return "green";
    }
  }

  Color _getColorForText() {
    if (this.starRates < 2) {
      return ConfigColor.tikiRed;
    } else if (this.starRates < 4) {
      return ConfigColor.tikiOrange;
    } else {
      return ConfigColor.green;
    }
  }

  String _getSecurityText() {
    if (this.starRates < 2) {
      return "not safe";
    } else if (this.starRates < 4) {
      return "somewhat safe";
    } else {
      return "very safe";
    }
  }
}
