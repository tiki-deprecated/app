import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';

class TikiBackground extends StatelessWidget {
  final Widget topLeft;
  final Widget topCenter;
  final Widget topRight;
  final Widget centerLeft;
  final Widget center;
  final Widget centerRight;
  final Widget bottomLeft;
  final Widget bottomCenter;
  final Widget bottomRight;
  final Color backgroundColor;

  TikiBackground(
      {this.topLeft,
      this.topRight,
      this.bottomLeft,
      this.bottomRight,
      this.backgroundColor,
      this.topCenter,
      this.centerLeft,
      this.center,
      this.centerRight,
      this.bottomCenter});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: backgroundColor ?? ConfigColor.serenade)),
      Align(alignment: Alignment.topLeft, child: topLeft ?? Container()),
      Align(alignment: Alignment.topCenter, child: topCenter ?? Container()),
      Align(alignment: Alignment.topRight, child: topRight ?? Container()),
      Align(alignment: Alignment.centerLeft, child: centerLeft ?? Container()),
      Align(alignment: Alignment.center, child: center ?? Container()),
      Align(alignment: Alignment.centerRight, child: centerRight ?? Container()),
      Align(alignment: Alignment.bottomLeft, child: bottomLeft ?? Container()),
      Align(alignment: Alignment.bottomCenter, child: bottomCenter ?? Container()),
      Align(
          alignment: Alignment.bottomRight, child: bottomRight ?? Container()),
    ]);
  }
}
