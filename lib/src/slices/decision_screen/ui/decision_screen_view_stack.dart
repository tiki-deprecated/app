import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
        child: Stack(clipBehavior: Clip.none, children: [
          noCardsPlaceholder,
          ...children,
        ]));
  }
}
