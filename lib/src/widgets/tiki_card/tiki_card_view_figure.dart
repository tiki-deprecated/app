import 'package:flutter/material.dart';

class TikiCardViewFigure extends StatelessWidget {
  final Widget child;

  TikiCardViewFigure(this.child);

  @override
  Widget build(BuildContext context) {
    return Center(child: child);
  }
}
