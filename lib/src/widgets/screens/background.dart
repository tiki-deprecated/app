import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';

class TikiBackground extends StatelessWidget {
  final Widget topLeft;
  final Widget topRight;
  final Widget bottomLeft;
  final Widget bottomRight;
  final Color backgroundColor;

  TikiBackground(
      {this.topLeft,
      this.topRight,
      this.bottomLeft,
      this.bottomRight,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: backgroundColor ?? ConfigColor.serenade)),
      Align(alignment: Alignment.topLeft, child: topLeft ?? Container()),
      Align(alignment: Alignment.topRight, child: topRight ?? Container()),
      Align(alignment: Alignment.bottomLeft, child: bottomLeft ?? Container()),
      Align(
          alignment: Alignment.bottomRight, child: bottomRight ?? Container()),
    ]);
  }
}
