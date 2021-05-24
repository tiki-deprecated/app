import 'package:flutter/material.dart';

class TikiCardFigure extends StatelessWidget {
  final Widget child;

  TikiCardFigure(this.child);

  @override
  Widget build(BuildContext context) {
    return Center(child: child);
  }
}
