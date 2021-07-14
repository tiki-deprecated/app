import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardViewFeedback extends StatefulWidget {
  final Widget child;

  DecisionCardViewFeedback({required this.child});

  @override
  State<StatefulWidget> createState() => _DecisionCardViewFeedbackState();
}

class _DecisionCardViewFeedbackState extends State<DecisionCardViewFeedback> {
  double delta = 0;
  late BoxConstraints constraints;

  get angle =>
      delta.abs() / SizerUtil.width > 45 ? 45 : -delta / SizerUtil.width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragUpdate: onDragUpdate,
        child: Material(
            child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Transform(
                    transform: Matrix4.rotationZ(angle),
                    alignment: FractionalOffset.topCenter,
                    child: Stack(children: [
                      Icon(Icons.check),
                      widget.child,
                      Icon(Icons.close)
                    ])))));
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      delta += details.delta.dx;
    });
  }
}
