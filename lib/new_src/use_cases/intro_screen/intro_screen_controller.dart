import 'package:flutter/material.dart';

import '../../controller.dart';
import 'intro_screen_use_case.dart';

class IntroScreenController extends Controller{

  final IntroScreenUseCase introScreenUseCase;

  IntroScreenController(this.introScreenUseCase);

  void navigateToNextScreen(context){
    if(!introScreenUseCase.isLastSlide()) {
      introScreenUseCase.moveToNextScreen(context);
    }else{
      skipToLogin(context);
    }
  }

  void skipToLogin(context){
    introScreenUseCase.skipToLogin(context);
  }

  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity! < 0) navigateToNextScreen(context);
  }


}
