import 'package:app/src/config/config_color.dart';
import 'package:app/src/widgets/header_bar/header_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ConfigColor.greyOne),
      SafeArea(
          child: Column(children: [
        HeaderBar(),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.w))),
                width: double.infinity,
                margin: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
                child: Text("Hi")))
      ]))
    ])));
  }
}
