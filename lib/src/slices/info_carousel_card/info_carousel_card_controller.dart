/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';

class InfoCarouselCardController {
  late DragStartDetails startVerticalDragDetails;
  late DragUpdateDetails updateVerticalDragDetails;

  calculateAnimation(double initialValue, double rate, double minimalValue) {
    double decrease = rate * initialValue;
    return initialValue - decrease > minimalValue
        ? initialValue - decrease
        : minimalValue;
  }

  setStartVerticalDragDetails(dragDetails) =>
      startVerticalDragDetails = dragDetails;

  setUpdateVerticalDragDetails(dragDetails) =>
      updateVerticalDragDetails = dragDetails;

  onVerticalDragEnd(endDetails, animationController) {
    double dx = updateVerticalDragDetails.globalPosition.dx -
        startVerticalDragDetails.globalPosition.dx;
    double dy = updateVerticalDragDetails.globalPosition.dy -
        startVerticalDragDetails.globalPosition.dy;
    double velocity = endDetails.primaryVelocity ?? 0;

    if (dx < 0) dx = -dx;
    if (dy < 0) dy = -dy;

    if (velocity < 0) {
      animationController.animateTo(1.0, curve: Curves.easeOut);
    }

    if (velocity > 0) {
      animationController.animateTo(0.0, curve: Curves.easeOut);
    }
  }

  shareCard(BuildContext context, shareMessage, socialMediaImg) {}

  launchUrl(String buttonUrl) {}
}
