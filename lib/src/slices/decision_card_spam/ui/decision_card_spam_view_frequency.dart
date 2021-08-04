import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewFrequency extends StatelessWidget {
  final frequency;

  final category;

  DecisionCardSpamViewFrequency(String this.frequency, String this.category);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(padding: EdgeInsets.only(top: 2.8.h)),
        Text("They send you emails",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
        Padding(padding: EdgeInsets.only(top: 0.2.h)),
        Text('${frequency[0].toUpperCase()}${frequency.substring(1)}',
            style: TextStyle(
                fontFamily: "Koara",
                fontSize: 32.sp,
                height: 1.2,
                fontWeight: FontWeight.w800,
                color: _getTextColor(frequency))),
        Padding(padding: EdgeInsets.only(top: 0.5.h)),
        _getCategory(this.category)
      ],
    );
  }

  _getTextColor(String frequency) {
    switch (frequency) {
      case "monthly":
        return ConfigColor.green;
      case "daily":
        return ConfigColor.red;
      case "weekly":
        return ConfigColor.tikiOrange;
    }
  }

  _getCategory(category) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('in'),
          Padding(
            padding: EdgeInsets.only(left: 3.sp),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ConfigColor.greySix, width: 1.sp),
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 10.sp),
              child: Row(
                children: [
                  Icon(
                    Icons.sell,
                    color: ConfigColor.greySix,
                    size: 12.sp,
                  ),
                  Padding(padding: EdgeInsets.only(left: 6.sp)),
                  Text(
                      "${category[0].toUpperCase()}${category.substring(1).toLowerCase()}",
                      style: TextStyle(
                          color: ConfigColor.greySix,
                          fontWeight: FontWeight.bold))
                ],
              ))
        ]);
  }
}
