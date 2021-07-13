import 'package:flutter/material.dart';

class DecisionScreenViewStack extends StatelessWidget {
  final List<Widget> children;
  final Widget noCardsPlaceholder;

  const DecisionScreenViewStack(
      {Key? key, required this.noCardsPlaceholder, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ...children,
      noCardsPlaceholder,
    ]);
  }
}
