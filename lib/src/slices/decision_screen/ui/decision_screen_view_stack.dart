import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionScreenViewStack extends StatelessWidget {
  static const num _radius = 4;

  final List<Widget> children;
  final Widget noCardsPlaceholder;

  const DecisionScreenViewStack(
      {Key? key, required this.noCardsPlaceholder, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_radius.w))),
        width: double.infinity,
        margin: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(_radius.w)),
            child: Stack(children: [
              noCardsPlaceholder,
              ...children,
            ])));
  }
}
