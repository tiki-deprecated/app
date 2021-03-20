import 'package:app/src/features/intro_slider/intro_slider_bloc.dart';
import 'package:app/src/features/intro_slider/intro_slider_model.dart';
import 'package:flutter/material.dart';

class IntroSliderBlocProvider extends InheritedWidget {
  final IntroSliderBloc _bloc;

  IntroSliderBlocProvider(IntroSliderModel init,
      {Key? key, required Widget child})
      : _bloc = IntroSliderBloc(init),
        super(key: key, child: child);

  IntroSliderBloc get bloc => _bloc;

  static IntroSliderBlocProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<IntroSliderBlocProvider>();
  }

  @override
  bool updateShouldNotify(IntroSliderBlocProvider oldWidget) {
    return false;
  }
}
