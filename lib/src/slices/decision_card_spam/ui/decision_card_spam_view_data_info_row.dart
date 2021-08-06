import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewDataInfoRow extends StatelessWidget {
  final sinceYear;
  final totalEmails;
  final opened;

  const DecisionCardSpamViewDataInfoRow(
      this.sinceYear, this.totalEmails, this.opened);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            child: Stack(children: [
              Center(child: HelperImage("vertical-separator", height: 12.h)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DecisionCardSpamViewSent(this.totalEmails, this.sinceYear),
                    DecisionCardSpamViewOpened(this.opened)
                  ])
            ])));
  }
}

class DecisionCardSpamViewOpened extends StatelessWidget {
  final percent;

  DecisionCardSpamViewOpened(this.percent);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("You've opened",
          style: TextStyle(
              fontFamily: "Nunito sans", color: ConfigColor.tikiBlue)),
      Padding(
        padding: EdgeInsets.only(bottom: 1.h),
      ),
      SizedBox(
          height: 9.h,
          width: 9.h,
          child: Stack(children: [
            Center(
                child: RichText(
                    text: TextSpan(
                        text: "${this.percent.round().toString()}",
                        style: TextStyle(
                            color: _getProgressColor(this.percent),
                            fontFamily: 'koara',
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700),
                        children: [
                  TextSpan(
                    text: " %",
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.normal),
                  )
                ]))),
            SizedBox(
              height: 9.h,
              width: 9.h,
              child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  backgroundColor: ConfigColor.greyThree,
                  value: this.percent / 100,
                  color: _getProgressColor(this.percent)),
            )
          ])),
      Padding(
        padding: EdgeInsets.only(bottom: 1.h),
      ),
      Text("of their emails")
    ]);
  }

  _getProgressColor(percent) {
    if (percent < 50) {
      return ConfigColor.tikiOrange;
    } else {
      return ConfigColor.green;
    }
  }
}

class DecisionCardSpamViewSent extends StatelessWidget {
  final totalEmails;
  final sinceYear;

  DecisionCardSpamViewSent(this.totalEmails, this.sinceYear);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("They've sent you"),
        Padding(padding: EdgeInsets.only(bottom: 5)),
        Text(
          this.totalEmails.toString(),
          style: TextStyle(
              fontFamily: ConfigFont.familyKoara,
              fontSize: 45.sp,
              fontWeight: FontWeight.bold),
        ),
        Text("emails",
            style: TextStyle(height: 0.5, fontWeight: FontWeight.bold)),
        Padding(padding: EdgeInsets.only(bottom: 10)),
        ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                color: ConfigColor.tikiBlue,
                child: Row(
                  children: [
                    Icon(Icons.calendar_today,
                        color: Colors.white, size: 10.sp),
                    Text(
                      " since ${this.sinceYear.toString()}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    )
                  ],
                )))
      ],
    );
  }
}
