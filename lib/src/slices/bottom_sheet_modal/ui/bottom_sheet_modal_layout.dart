import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomSheetModalLayout extends StatelessWidget{

  final Widget? child;

  const BottomSheetModalLayout({
    Key? key,
    this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 85.h,
        child: this.child ?? Container()
    );
  }
}

