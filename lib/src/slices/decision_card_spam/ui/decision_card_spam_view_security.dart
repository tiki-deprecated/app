import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewSecurity extends StatelessWidget {
  final double? starRates;
  final int? sensitivity;
  final int? hacking;

  DecisionCardSpamViewSecurity({starRates, sensitivity, hacking})
      : this.starRates = starRates != null ? (1 - starRates) * 5 : null,
        this.sensitivity =
            sensitivity != null ? (sensitivity! * 10).round() : null,
        this.hacking = hacking != null ? (hacking! * 10).round() : null;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: _getStars()),
      Padding(
        padding: EdgeInsets.only(top: 1.h),
      ),
      this.starRates != null
          ? RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: ConfigFont.familyKoara,
                      color: ConfigColor.greyFour,
                      fontSize: 15.sp),
                  text: "Your data is ",
                  children: [
                    TextSpan(
                        text: _getSecurityText(this.starRates ?? 0),
                        style: TextStyle(color: _getColorForText())),
                    _getInfoIcon(context)
                  ]),
            )
          : RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: ConfigFont.familyKoara,
                      color: ConfigColor.greyFour,
                      fontSize: 15.sp),
                  text: "No data score info yet",
                  children: [_getInfoIcon(context)]),
            ),
    ]));
  }

  List<Widget> _getStars() {
    var color = _getColor();
    var starRate = this.starRates ?? 0;
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
    if (this.starRates == null) {
      return "grey";
    } else {
      var starRate = this.starRates ?? 0;
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
    var starRates = this.starRates ?? 0;
    if (this.starRates == null) {
      return ConfigColor.greyFive;
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

  Future<void> showModal(BuildContext context,
      {num? sensitivity, num? hacking}) {
    var spacing = 2.4.h;
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: ConfigColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.5.h))),
        builder: (BuildContext context) => Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: spacing),
                  ),
                  Divider(
                    height: spacing,
                    thickness: 5,
                    color: ConfigColor.greyThree,
                    indent: 38.w,
                    endIndent: 38.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: spacing * 1.5),
                  ),
                  Center(
                      child: Text(
                    'Security score',
                    style: TextStyle(
                        color: ConfigColor.tikiBlue,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: spacing * 1.5),
                  ),
                  sensitivity == null
                      ? DecisionCardSpamViewSecurityEmpty()
                      : Container(),
                  RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text:
                              'For each email list that emails you, we show\nyou a rating which we call a ',
                          style: TextStyle(
                            color: ConfigColor.tikiBlue,
                          ),
                          children: [
                            TextSpan(
                                text: 'Security score.',
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ])),
                  Padding(
                    padding: EdgeInsets.only(top: spacing),
                  ),
                  Text('The security score is determined by two ratings:'),
                  Padding(
                    padding: EdgeInsets.only(top: spacing),
                  ),
                  sensitivity != null
                      ? DecisionCardSpamViewSecurityScore(
                          hacking: this.hacking, sensitivity: this.sensitivity)
                      : Container(),
                  DecisionCardSpamViewSecuritySensivityText(),
                  Padding(
                    padding: EdgeInsets.only(top: spacing),
                  ),
                  DecisionCardSpamViewSecurityHackingText(),
                  Padding(
                    padding: EdgeInsets.only(top: spacing * 2),
                  ),
                  Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(90.w),
                      primary: ConfigColor.orange,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3.w))),
                    ),
                    child: Text("OK, got it",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.of(context).pop(),
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: spacing * 3),
                  ),
                ])));
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
                color: ConfigColor.greyFour,
                size: 17.sp,
              ),
              onTap: () => showModal(context,
                  sensitivity: this.sensitivity, hacking: this.hacking),
            )));
  }
}

class DecisionCardSpamViewSecurityHackingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('HACKING SCORE',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: ConfigColor.greyFour, fontWeight: FontWeight.bold)),
      Text(
          'A rating based on known recent security\nbreaches/hacks (from www.XXXXXXXXX.com)',
          style: TextStyle(fontWeight: FontWeight.bold))
    ]);
  }
}

class DecisionCardSpamViewSecuritySensivityText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('SENSITIVITY SCORE',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: ConfigColor.greyFour, fontWeight: FontWeight.bold)),
      Text(
          'A rating based on the sensitivity of the\nbusiness emailing you, for example whether\nthey are holding nmedical or financial\ninformation vs a clothing company. We find this\ninformation at www.XXXXXXXXX.com.',
          style: TextStyle(fontWeight: FontWeight.bold))
    ]);
  }
}

class DecisionCardSpamViewSecurityEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
          'We’re sorry that we cannot provide you with a\nsecurity score for this email list right now.\nFind out more info about security score below.',
          style: TextStyle(
              color: ConfigColor.tikiRed, fontWeight: FontWeight.bold)),
      Padding(padding: EdgeInsets.only(top: 2.h)),
    ]);
  }
}

class DecisionCardSpamViewSecurityScore extends StatelessWidget {
  final int? hacking;
  final int? sensitivity;

  const DecisionCardSpamViewSecurityScore({this.hacking, this.sensitivity});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(children: [
        Center(child: HelperImage("vertical-separator", height: 8.h)),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecisionCardSpamViewSecurityScoreNumbers(
                  this.sensitivity, 'SENSITIVITY'),
              DecisionCardSpamViewSecurityScoreNumbers(this.hacking, 'HACKING'),
            ])
      ]),
      Padding(
        padding: EdgeInsets.only(top: 2.4.h),
      ),
    ]);
  }
}

class DecisionCardSpamViewSecurityScoreNumbers extends StatelessWidget {
  final score;
  final text;

  const DecisionCardSpamViewSecurityScoreNumbers(this.score, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("${this.score} / 10",
          style: TextStyle(
              color: ConfigColor.tikiBlue,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold)),
      Text(this.text,
          style: TextStyle(
              color: ConfigColor.greyFive,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold))
    ]);
  }
}
