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
        Text("They send you emails",
            style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: ConfigColor.tikiBlue)),
        Padding(padding: EdgeInsets.only(top: 0.75.h)),
        Text('${frequency[0].toUpperCase()}${frequency.substring(1)}',
            style: TextStyle(
                fontFamily: "Koara",
                fontSize: 26.sp,
                fontWeight: FontWeight.w800,
                color: _getTextColor(frequency))),
        Padding(padding: EdgeInsets.only(top: 0.75.h)),
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
          Text('in',
              style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: ConfigColor.tikiBlue)),
          Padding(
            padding: EdgeInsets.only(left: 3.sp),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ConfigColor.greySeven, width: 1.sp),
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 8.sp),
              child: Row(
                children: [
                  Icon(
                    Icons.sell,
                    color: ConfigColor.greySeven,
                    size: 12.sp,
                  ),
                  Padding(padding: EdgeInsets.only(left: 4.sp)),
                  Text(
                      "${category[0].toUpperCase()}${category.substring(1).toLowerCase()}",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: ConfigColor.greySeven,
                          fontWeight: FontWeight.w800))
                ],
              ))
        ]);
  }
}
