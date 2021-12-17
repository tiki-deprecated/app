import 'package:flutter/material.dart';

class BottomsheetModalLayout extends StatelessWidget{

  final List<Widget> children;

  const BottomsheetModalLayout({
    Key? key,
    this.children = const <Widget>[]}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 85.h,
        child: Column(mainAxisSize: MainAxisSize.min, children: this.children)
    );
  }
}

