import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardView extends StatefulWidget {
  final Widget child;
  final Function onSwipeRight;
  final Function onSwipeLeft;

  DecisionCardView(
      {required this.child,
      required this.onSwipeRight,
      required this.onSwipeLeft});

  @override
  State<StatefulWidget> createState() => _DecisionCardViewState();
}

class _DecisionCardViewState extends State<DecisionCardView> {
  double delta = 0;
  late BoxConstraints constraints;

  get angle =>
      delta.abs() / SizerUtil.width > 45 ? 45 : -delta / SizerUtil.width;

  @override
  Widget build(BuildContext context) {
    ;
    print(angle);
    return Positioned(
        left: 0,
        child: LayoutBuilder(
            builder: (context, constraints) => Container(
                constraints: constraints,
                child: Container(
                    constraints: constraints,
                    child: GestureDetector(
                        onHorizontalDragEnd: onHorizontalDragEnd,
                        onHorizontalDragUpdate: onDragUpdate,
                        child: Transform(
                            transform: Matrix4.rotationZ(angle),
                            alignment: FractionalOffset.topCenter,
                            child: Stack(children: [
                              Icon(Icons.check),
                              widget.child,
                              Icon(Icons.close)
                            ])))))));
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      delta += details.delta.dx;
    });
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      delta = 0;
    });
  }
}
