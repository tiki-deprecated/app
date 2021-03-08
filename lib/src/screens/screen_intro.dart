import 'package:app/src/features/intro_slider/intro_slider.dart';
import 'package:app/src/features/intro_slider/intro_slider_model.dart';
import 'package:app/src/features/intro_slider/intro_slider_model_content.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenIntro extends PlatformScaffold {
  final IntroSliderModel sliderModelConfig = IntroSliderModel([
    IntroSliderModelContent(Colors.blue, 'Page 1'),
    IntroSliderModelContent(Colors.red, 'Page 2'),
    IntroSliderModelContent(Colors.green, 'Page 3')
  ], 0);

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: IntroSlider(sliderModelConfig));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: IntroSlider(sliderModelConfig));
  }
}
