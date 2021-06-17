import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'intro_screen_service.dart';

class IntroScreenController{

  void navigateToNextScreen(context){
    var service = Provider.of<IntroScreenService>(context, listen: false);
    if(!service.isLastSlide()) {
      service.moveToNextScreen(context);
    }else{
      skipToLogin(context);
    }
  }

  void skipToLogin(context){
    var service = Provider.of<IntroScreenService>(context, listen: false);
    service.skipToLogin(context);
  }

  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity! < 0) navigateToNextScreen(context);
  }
}