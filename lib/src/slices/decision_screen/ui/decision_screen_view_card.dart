import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionScreenViewCard extends StatefulWidget {
  final Widget child;
  final Function onSwipeRight;
  final Function onSwipeLeft;
  final BoxConstraints constraints;

  DecisionScreenViewCard(
      {required this.child,
      required this.onSwipeRight,
      required this.onSwipeLeft,
      required this.constraints});

  @override
  State<StatefulWidget> createState() => _DecisionCardViewState();
}

class _DecisionCardViewState extends State<DecisionScreenViewCard> {
  static const num _radius = 4;
  double delta = 0;
  double top = 0;

  double lastDx = 0;

  get angle =>
      delta.abs() / SizerUtil.width > 45 ? 45 : -delta / SizerUtil.width;

  double getopacityYes() {
    if (delta < 0) {
      return 0;
    }
    return delta.abs() * 3 / SizerUtil.width > 1
        ? 1.0
        : delta.abs() * 3 / SizerUtil.width;
  }

  double getOpacityNo() {
    if (delta > 0) {
      return 0;
    }
    return delta.abs() * 3 / SizerUtil.width > 1
        ? 1.0
        : delta.abs() * 3 / SizerUtil.width;
  }

  get left => delta;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: delta,
        top: top,
        child: Container(
            width: widget.constraints.maxWidth,
            height: widget.constraints.maxHeight,
            padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.w),
            child: GestureDetector(
                onPanEnd: onDragEnd,
                onPanUpdate: onDragUpdate,
                child: Transform(
                    transform: Matrix4.rotationZ(angle),
                    alignment: FractionalOffset.topCenter,
                    child: Stack(clipBehavior: Clip.none, children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_radius.w)),
                        child: widget.child,
                      ),
                      Positioned(
                          left: -60,
                          top: 100,
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Opacity(
                                  opacity: getopacityYes(),
                                  child:
                                      HelperImage("yes-label", height: 30.h)))),
                      Positioned(
                          right: -60,
                          top: 100,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Opacity(
                                opacity: getOpacityNo(),
                                child: HelperImage("nope-label", height: 30.h)),
                          ))
                    ])))));
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      top += details.delta.dy;
      delta += details.delta.dx;
    });
  }

  void onDragEnd(DragEndDetails details) {
    if (delta > 100) {
      widget.onSwipeRight();
    } else if (delta < -100) {
      widget.onSwipeLeft();
    }
    setState(() {
      delta = 0;
      top = 0;
    });
  }
}
