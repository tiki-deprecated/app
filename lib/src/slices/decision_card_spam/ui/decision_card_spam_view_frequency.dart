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
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
        Text('${frequency[0].toUpperCase()}${frequency.substring(1)}',
            style: TextStyle(
                fontFamily: "Koara",
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
                color: _getTextColor(frequency))),
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
            padding: EdgeInsets.only(left: 12.sp),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ConfigColor.greySix, width: 1.sp),
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
              child: Row(
                children: [
                  Icon(Icons.sell, color: ConfigColor.greySix),
                  Text(
                      "${category[0].toUpperCase()}${category.substring(1).toLowerCase()}",
                      style: TextStyle(color: ConfigColor.greySix))
                ],
              ))
        ]);
  }
}
