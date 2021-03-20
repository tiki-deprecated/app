import 'package:app/src/constants/constants_colors.dart';
import 'package:app/src/constants/constants_strings.dart';
import 'package:app/src/features/intro_slider/intro_slider.dart';
import 'package:app/src/features/intro_slider/intro_slider_model.dart';
import 'package:app/src/features/intro_slider/intro_slider_model_content.dart';
import 'package:app/src/screens/screen_home.dart';
import 'package:app/src/screens/screen_login.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenIntro extends PlatformScaffold {
  final IntroSliderModel sliderModelConfig = IntroSliderModel([
    IntroSliderModelContent(
        ConstantsColors.SUNGLOW,
        ConstantsStrings.INTRO_1_HEADER,
        ConstantsStrings.INTRO_1_SUBTITLE,
        ConstantsStrings.INTRO_1_BUTTON_TEXT),
    IntroSliderModelContent(
        ConstantsColors.KOURNIKOVA,
        ConstantsStrings.INTRO_2_HEADER,
        ConstantsStrings.INTRO_2_SUBTITLE,
        ConstantsStrings.INTRO_2_BUTTON_TEXT),
    IntroSliderModelContent(
        ConstantsColors.MACARONI_AND_CHEESE,
        ConstantsStrings.INTRO_3_HEADER,
        ConstantsStrings.INTRO_3_SUBTITLE,
        ConstantsStrings.INTRO_3_BUTTON_TEXT)
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
      IntroSlider(sliderModelConfig, ScreenHome()),
      Align(
          alignment: Alignment.bottomLeft,
          child: Image(image: AssetImage('res/images/intro-blob.png'))),
      Align(
          alignment: Alignment.bottomRight,
          child: Image(image: AssetImage('res/images/intro-1-pineapple.png'))),
      Align(
          alignment: Alignment(0.85, -0.85),
          child: TextButton(
              onPressed: () {
                Navigator.push(context, platformPageRoute(ScreenLogin()));
              },
              child: Text('Skip',
                  style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18))))
    ]);
  }
}
