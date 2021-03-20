import 'package:app/src/features/intro_slider/intro_slider_bloc_provider.dart';
import 'package:app/src/features/intro_slider/intro_slider_model.dart';
import 'package:app/src/features/intro_slider/intro_slider_ui.dart';
import 'package:flutter/material.dart';

class IntroSlider extends StatelessWidget {
  final IntroSliderModel _init;
  final Widget _destination;

  IntroSlider(this._init, this._destination);

  @override
  Widget build(BuildContext context) {
    return IntroSliderBlocProvider(
      _init,
      child: IntroSliderUI(_destination),
    );
  }
}
