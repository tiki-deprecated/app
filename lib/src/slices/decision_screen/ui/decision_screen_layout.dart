import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/decision_screen/ui/decision_screen_view_stack.dart';
import 'package:app/src/widgets/header_bar/header_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'decision_screen_view_empty.dart';

class DecisionScreenLayout extends StatelessWidget {
  static const num _radius = 4;

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
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_radius.w))),
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_radius.w)),
                        child: DecisionScreenViewStack(
                            noCardsPlaceholder: DecisionScreenViewEmpty(),
                            children: [])))))
      ]))
    ])));
  }
}
