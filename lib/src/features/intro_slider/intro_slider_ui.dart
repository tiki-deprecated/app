import 'package:app/src/constants/constants_colors.dart';
import 'package:app/src/features/intro_slider/intro_slider_bloc.dart';
import 'package:app/src/features/intro_slider/intro_slider_bloc_provider.dart';
import 'package:app/src/features/intro_slider/intro_slider_model.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroSliderUI extends StatefulWidget {
  Widget _destination;

  IntroSliderUI(this._destination);

  @override
  _IntroSliderUI createState() => _IntroSliderUI(_destination);
}

class _IntroSliderUI extends State<IntroSliderUI> {
  IntroSliderBloc _introSliderBloc;
  Widget _destination;

  static final double _lrPadding = 30;
  static final double _vMargin = 20;
  static final double _vMarginStart = 300;
  static final double _fsizeTitle = 40;
  static final double _fsizeSubtitle = 20;
  static final double _fsizeButton = 22;
  static final double _sizeDot = 8;
  static final double _heightButton = 50;
  static final double _widthButton = 175;

  _IntroSliderUI(this._destination);

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
            initialData: _introSliderBloc.introSliderModel,
            builder: (context, AsyncSnapshot<IntroSliderModel> snapshot) {
              return Row(children: [
                Expanded(
                    child: Container(
                        color:
                            snapshot.data.content[snapshot.data.pos].background,
                        padding: EdgeInsets.only(
                            left: _lrPadding, right: _lrPadding),
                        child: Column(children: [
                          _title(
                              snapshot.data.content[snapshot.data.pos].title),
                          _subtitle(snapshot
                              .data.content[snapshot.data.pos].subtitle),
                          _positionDots(snapshot.data.pos),
                          _button(
                              snapshot
                                  .data.content[snapshot.data.pos].buttonText,
                              destination: snapshot.data.pos >=
                                      snapshot.data.content.length - 1
                                  ? _destination
                                  : null)
                        ])))
              ]);
            }));
  }

  @override
  void dispose() {
    _introSliderBloc.dispose();
    super.dispose();
  }

  Widget _title(String text) {
    return Container(
        margin: EdgeInsets.only(top: _vMarginStart),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: _fsizeTitle,
                    fontWeight: FontWeight.bold,
                    color: ConstantsColors.MARDI_GRAS))));
  }

  Widget _subtitle(String text) {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text,
                style: GoogleFonts.nunitoSans(
                    fontSize: _fsizeSubtitle,
                    fontWeight: FontWeight.bold,
                    color: ConstantsColors.MARDI_GRAS))));
  }

  Widget _positionDots(int pos) {
    List<Widget> dots = List.generate(3, (i) => _dot(i == pos ? true : false));
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Row(
          children: dots,
        ));
  }

  Widget _dot(bool active) {
    return Container(
      height: _sizeDot,
      width: _sizeDot,
      margin: EdgeInsets.only(left: _sizeDot * 0.5, right: _sizeDot * 0.5),
      decoration: BoxDecoration(
          color: active ? ConstantsColors.MARDI_GRAS : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(_sizeDot * 2))),
    );
  }

  Widget _button(String text, {Widget destination}) {
    return Container(
        margin: EdgeInsets.only(top: _vMargin * 2),
        child: Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_vMargin * 2))),
                    primary: ConstantsColors.MARDI_GRAS),
                child: Container(
                    width: _widthButton,
                    height: _heightButton,
                    child: Center(
                        child: Text(text,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w800,
                                fontSize: _fsizeButton,
                                letterSpacing: 1)))),
                onPressed: () {
                  if (destination != null)
                    Navigator.push(context, platformPageRoute(destination));
                  else
                    _introSliderBloc.increment();
                })));
  }
}
