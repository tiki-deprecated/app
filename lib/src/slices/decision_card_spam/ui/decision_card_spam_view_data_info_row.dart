import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewDataInfoRow extends StatelessWidget {
  final sinceYear;
  final totalEmails;

  const DecisionCardSpamViewDataInfoRow(
      {Key? key, this.sinceYear, this.totalEmails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DecisionCardSpamViewSent(this.totalEmails, this.sinceYear),
                  HelperImage("vertical-separator", height: 12.h),
                  DecisionCardSpamViewOpened(64)
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
        Text(this.totalEmails.toString()),
        Text("emails"),
        Container(
            color: ConfigColor.tikiBlue,
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white),
                Text(" since ${this.sinceYear.toString()}")
              ],
            ))
      ],
    );
  }
}
