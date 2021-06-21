import 'package:flutter/material.dart';

import 'card-content.dart';
import 'cover.dart';

class AnimatedCardContainer extends StatefulWidget {
  final BoxConstraints constraints;
  final Map coverData;
  final Map cardData;

  const AnimatedCardContainer(this.constraints, this.coverData, this.cardData);

  @override
  State<StatefulWidget> createState() => _AnimatedCardContainerState();
}

class _AnimatedCardContainerState extends State<AnimatedCardContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late DragStartDetails startVerticalDragDetails;
  late DragUpdateDetails updateVerticalDragDetails;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minHeight: widget.constraints.maxHeight,
        ),
        color: Colors.transparent,
        child:  ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: SingleChildScrollView(
            child: Column(
          children: [
            GestureDetector(
              onVerticalDragStart: (dragDetails) {
                startVerticalDragDetails = dragDetails;
              },
              onVerticalDragUpdate: (dragDetails) {
                updateVerticalDragDetails = dragDetails;
              },
              onVerticalDragEnd: (endDetails) {
                double dx = updateVerticalDragDetails.globalPosition.dx -
                    startVerticalDragDetails.globalPosition.dx;
                double dy = updateVerticalDragDetails.globalPosition.dy -
                    startVerticalDragDetails.globalPosition.dy;
                double velocity = endDetails.primaryVelocity ?? 0;

                //Convert values to be positive
                if (dx < 0) dx = -dx;
                if (dy < 0) dy = -dy;

                if (velocity < 0) {
                  controller.animateTo(1, curve: Curves.easeOut);
                }
                if (velocity > 0) {
                  controller.animateTo(0, curve: Curves.easeOut);
                }
              },
              child: Container(child:GestureDetector(
                onTap: () => controller.value == 1 ? controller.animateTo(0) : null,
                child: Cover(
                  controller: controller,
                  maxHeight: widget.constraints.maxHeight,
                  coverData: widget.coverData),
            ))),
            CardContent(widget.constraints, controller,
                cardContentData: widget.cardData)
          ],
        ))));
  }
}
