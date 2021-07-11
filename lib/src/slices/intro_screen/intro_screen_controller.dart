import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'intro_screen_service.dart';

class IntroScreenController {
  void navigateToNextScreen(context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    if (!service.isLastSlide()) {
      service.moveToNextScreen();
    } else {
      skipToLogin(context);
    }
  }

  void navigateToPreviousScreen(context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    if (!service.isFirstSlide()) {
      service.moveToPreviousScreen();
    }
  }

  void skipToLogin(context) {
    //var service = Provider.of<IntroScreenService>(context, listen: false);
    //service.skipToLogin();
    var service = Provider.of<LoginFlowService>(context, listen: false);
    service.to();
  }

  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity! < 0) navigateToNextScreen(context);
    if (dragEndDetails.primaryVelocity! > 0) navigateToPreviousScreen(context);
  }
}
