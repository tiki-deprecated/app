import 'package:app/src/features/intro_slider/intro_slider.dart';
import 'package:app/src/features/intro_slider/intro_slider_model.dart';
import 'package:app/src/features/intro_slider/intro_slider_model_content.dart';
import 'package:app/src/screens/screen_login.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenIntro extends PlatformScaffold {
  final IntroSliderModel sliderModelConfig = IntroSliderModel([
    IntroSliderModelContent(Colors.blue, 'Intro 1'),
    IntroSliderModelContent(Colors.red, 'Intro 2'),
    IntroSliderModelContent(Colors.green, 'Intro 3')
  ], 0);

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: _stack(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _stack(context));
  }

  Stack _stack(BuildContext context) {
    return Stack(children: [
      IntroSlider(sliderModelConfig),
      Align(
          alignment: Alignment(0.85, -0.85),
          child: TextButton(
              onPressed: () {
                Navigator.push(context, platformPageRoute(ScreenLogin()));
              },
              style: TextButton.styleFrom(primary: Colors.black),
              child: Text('Skip')))
    ]);
  }
}
