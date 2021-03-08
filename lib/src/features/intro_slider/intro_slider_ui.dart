import 'package:app/src/features/intro_slider/intro_slider_bloc.dart';
import 'package:app/src/features/intro_slider/intro_slider_bloc_provider.dart';
import 'package:app/src/features/intro_slider/intro_slider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroSliderUI extends StatefulWidget {
  @override
  _IntroSliderUI createState() => _IntroSliderUI();
}

class _IntroSliderUI extends State<IntroSliderUI> {
  IntroSliderBloc _introSliderBloc;

  @override
  Widget build(BuildContext context) {
    _introSliderBloc = IntroSliderBlocProvider.of(context).bloc;
    return GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity > 0) _introSliderBloc.decrement();
          if (details.primaryVelocity < 0) _introSliderBloc.increment();
        },
        child: StreamBuilder(
            stream: _introSliderBloc.introSliderObservable,
            builder: (context, AsyncSnapshot<IntroSliderModel> snapshot) {
              if (snapshot != null && !snapshot.hasError && snapshot.hasData) {
                return Container(
                    color: snapshot.data.content[snapshot.data.pos].background,
                    child: Center(
                        child: Text(
                            snapshot.data.content[snapshot.data.pos].text)));
              } else {
                return Container(
                    color: _introSliderBloc
                        .introSliderModel
                        .content[_introSliderBloc.introSliderModel.pos]
                        .background,
                    child: Center(
                        child: Text(_introSliderBloc
                            .introSliderModel
                            .content[_introSliderBloc.introSliderModel.pos]
                            .text)));
              }
            }));
  }

  @override
  void dispose() {
    _introSliderBloc.dispose();
    super.dispose();
  }
}
