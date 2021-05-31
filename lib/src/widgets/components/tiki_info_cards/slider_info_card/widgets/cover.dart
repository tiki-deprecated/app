import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cover extends AnimatedWidget {
  final maxHeight;
  final Map coverData;

  Cover(
      {Key? key,
      required AnimationController controller,
      required double this.maxHeight,
      required this.coverData})
      : super(key: key, listenable: controller);

  Animation<double> get _controllerValue => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: _calculateAnimation(maxHeight, _controllerValue.value, 150),
        padding: EdgeInsets.only(left: 25, top: 16, right: 16, bottom: 16),
        child: Stack(fit: StackFit.expand, children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: _calculateAnimation(60, _controllerValue.value, 0),
                  child: Opacity(
                      opacity: 1 - _controllerValue.value,
                      child: this.coverData['topHeader']))),
          Align(
              alignment: Alignment(_controllerValue.value, -1),
              child: Padding(
                  padding: EdgeInsets.only(
                      top: _calculateAnimation(50, _controllerValue.value, 0)),
                  child: HelperImage(this.coverData['image'],
                      width: _calculateAnimation(
                          300, _controllerValue.value, 170)))),
          Positioned(
              top: 330,
              child: Container(
                  height: _calculateAnimation(60, _controllerValue.value, 0),
                  child: Opacity(
                      opacity: _controllerValue.value * 2 <= 1
                          ? 1 - (_controllerValue.value * 2)
                          : 0,
                      child: Container(
                          height: _calculateAnimation(
                              60, _controllerValue.value, 0),
                          margin: EdgeInsets.only(bottom: 10),
                          width: double.maxFinite,
                          child: Text(this.coverData['subtitle'],
                              style: TextStyle(
                                  color: ConfigColor.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "NunitoSans")))))),
          Padding(
              padding: EdgeInsets.only(
                  top: _calculateAnimation(370, _controllerValue.value, 20)),
              child: Align(
                  alignment: Alignment(
                    -_controllerValue.value,
                    -1,
                  ),
                  child: Container(
                      width: _calculateAnimation(
                          MediaQuery.of(context).size.width,
                          _controllerValue.value,
                          170),
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              style: TextStyle(
                                  color: Color(0xFF0036B5),
                                  height: 1,
                                  fontFamily: "Koara",
                                  fontSize: _calculateAnimation(
                                      45, _controllerValue.value, 25),
                                  fontWeight: FontWeight.bold),
                              text: this.coverData['bigTextLighter'],
                              children: [
                                TextSpan(
                                    text: this.coverData['bigTextDarker'],
                                    style: TextStyle(
                                        color: ConfigColor.tikiBlue,
                                        height: 1,
                                        fontFamily: "Koara",
                                        fontSize: _calculateAnimation(
                                            45, _controllerValue.value, 25),
                                        fontWeight: FontWeight.bold))
                              ]))))),
          Padding(
              padding: EdgeInsets.only(
                top: 500,
              ),
              child: Opacity(
                  opacity: _controllerValue.value * 3 <= 1
                      ? 1 - (_controllerValue.value * 3)
                      : 0,
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.maxFinite,
                      child: Text(this.coverData['subText'],
                          style: TextStyle(
                              color: ConfigColor.tikiBlue,
                              fontFamily: "NunitoSans",
                              fontSize: 18,
                              fontWeight: FontWeight.w600))))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: _calculateAnimation(60, _controllerValue.value, 0),
                  child: Opacity(
                      opacity: _controllerValue.value * 2 <= 1
                          ? 1 - (_controllerValue.value * 2)
                          : 0,
                      child: Container(
                        height:
                            _calculateAnimation(60, _controllerValue.value, 0),
                        padding: EdgeInsets.only(bottom: 16),
                        child: HelperImage(
                          "arrow-up",
                          width: 60,
                        ),
                      ))))
        ]));
  }

  _calculateAnimation(double initialValue, double rate, double minimalValue) {
    double decrease = rate * initialValue;
    return initialValue - decrease > minimalValue
        ? initialValue - decrease
        : minimalValue;
  }
}
