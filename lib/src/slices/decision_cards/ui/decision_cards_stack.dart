import 'package:flutter/material.dart';

class DecisionCardsStack extends StatelessWidget {
  final List<Widget> children;
  final Widget noCardsPlaceholder;

  const DecisionCardsStack(
      {Key? key, required this.noCardsPlaceholder, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          ...children,
          noCardsPlaceholder,
        ]));
  }
}
