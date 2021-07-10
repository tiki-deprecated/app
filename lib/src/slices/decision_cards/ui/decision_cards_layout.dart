import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'decision_cards_stack.dart';

class DecisionCardsLayout extends StatelessWidget {
  final DecisionCardsStack child;

  const DecisionCardsLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        //TODO check with Anna the % of padding and margin (it's different from design system)
        margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: this.child);
  }
}
