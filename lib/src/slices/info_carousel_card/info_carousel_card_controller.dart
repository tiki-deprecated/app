/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'info_carousel_card_service.dart';

class InfoCarouselCardController {
  late DragStartDetails startVerticalDragDetails;
  late DragUpdateDetails updateVerticalDragDetails;
  AnimationController? animationController;
  double? scrollStartPos;
  double scrollUpdatePos = 0.0;

  calculateAnimation(double initialValue, double rate, double minimalValue) {
    double decrease = rate * initialValue;
    return initialValue - decrease > minimalValue
        ? initialValue - decrease
        : minimalValue;
  }

  setStartVerticalDragDetailsCover(dragDetails) =>
      startVerticalDragDetails = dragDetails;

  setUpdateVerticalDragDetailsCover(dragDetails) =>
      updateVerticalDragDetails = dragDetails;

  onVerticalDragEndCover(endDetails, animationController) {
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

  bool onScrollNotification(scrollNotification, animationController) {
    if (scrollNotification is ScrollStartNotification)
      scrollStartPos = scrollNotification.metrics.pixels;
    if (scrollNotification is ScrollUpdateNotification)
      scrollUpdatePos = scrollNotification.metrics.pixels;
    else if (scrollNotification is ScrollEndNotification &&
        scrollStartPos == 0.0 &&
        scrollUpdatePos == 0.0 &&
        scrollNotification.metrics.atEdge)
      animationController.animateTo(0.0, curve: Curves.easeOut);
    return false;
  }

  shareCard(BuildContext context, message, image) {
    var service = Provider.of<InfoCarouselCardService>(context, listen: false);
    service.shareCard(message, image);
  }

  openUrl(String? href) async {
    if (href != null && await canLaunch(href)) await launch(href);
  }
}
