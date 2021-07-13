import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardView extends StatelessWidget {
  final Widget child;
  final Function onSwipeRight;
  final Function onSwipeLeft;

  const DecisionCardView(
      {required this.child,
      required this.onSwipeRight,
      required this.onSwipeLeft});

  @override
  Widget build(BuildContext context) {
    return Draggable(
        onDragEnd: onDragEnd,
        childWhenDragging: Container(),
        feedback: child,
        child: child);
  }

  void onDragEnd(DraggableDetails details) {
    double edge = SizerUtil.width / 6;
    if (details.offset.dx < edge) print('left');
    if (details.offset.dx > edge) print('right');
  }
}
