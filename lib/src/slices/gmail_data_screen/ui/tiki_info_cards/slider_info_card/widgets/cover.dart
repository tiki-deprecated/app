import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
        height: _calculateAnimation(maxHeight, _controllerValue.value, PlatformRelativeSize.blockVertical*17.5),
        padding: EdgeInsets.only(
            left: PlatformRelativeSize.blockVertical*2.9,
            top: PlatformRelativeSize.blockVertical*1.9,
            right: PlatformRelativeSize.blockVertical*1.9,
            bottom:  PlatformRelativeSize.blockVertical*1.9),
        child: Stack(fit: StackFit.expand, children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: _calculateAnimation( PlatformRelativeSize.blockVertical*7, _controllerValue.value, 0),
                  child: Opacity(
                      opacity: 1 - _controllerValue.value,
                      child: this.coverData['topHeader']))),
          Align(
              alignment: Alignment(_controllerValue.value, -1),
              child: Padding(
                  padding: EdgeInsets.only(
                      top: _calculateAnimation( PlatformRelativeSize.blockVertical*5.8, _controllerValue.value, 0)),
                  child: HelperImage(this.coverData['image'],
                      width: _calculateAnimation(
                          PlatformRelativeSize.blockHorizontal*72.91, _controllerValue.value,  PlatformRelativeSize.blockVertical*19.7)))),
          Positioned(
              top:  PlatformRelativeSize.blockVertical*40,
              child: Container(
                  height: _calculateAnimation( PlatformRelativeSize.blockVertical*7, _controllerValue.value, 0),
                  child: Opacity(
                      opacity: _controllerValue.value * 2 <= 1
                          ? 1 - (_controllerValue.value * 2)
                          : 0,
                      child: Container(
                          height: _calculateAnimation(
                              6.98, _controllerValue.value, 0),
                          margin: EdgeInsets.only(bottom: 10),
                          width: double.maxFinite,
                          child: Text(this.coverData['subtitle'],
                              style: TextStyle(
                                  color: ConfigColor.orange,
                                  fontSize:  PlatformRelativeSize.blockVertical*2.3,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "NunitoSans")))))),
          Padding(
              padding: EdgeInsets.only(
                  top: _calculateAnimation( PlatformRelativeSize.blockVertical*44, _controllerValue.value,  PlatformRelativeSize.blockVertical*2.32)),
              child: Align(
                  alignment: Alignment(
                    -_controllerValue.value,
                    -1,
                  ),
                  child: Container(
                      width: _calculateAnimation(
                          MediaQuery.of(context).size.width,
                          _controllerValue.value,
                          PlatformRelativeSize.blockHorizontal*41),
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              style: TextStyle(
                                  color: Color(0xFF0036B5),
                                  height: 1,
                                  fontFamily: "Koara",
                                  fontSize: _calculateAnimation(
                                      PlatformRelativeSize.blockVertical*5.23, _controllerValue.value,  PlatformRelativeSize.blockVertical*2.9),
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
                                            PlatformRelativeSize.blockVertical*5.23, _controllerValue.value,  PlatformRelativeSize.blockVertical*2.9),
                                        fontWeight: FontWeight.bold))
                              ]))))),
          Padding(
              padding: EdgeInsets.only(
                top:  PlatformRelativeSize.blockVertical*59,
              ),
              child: Opacity(
                  opacity: _controllerValue.value * 3 <= 1
                      ? 1 - (_controllerValue.value * 3)
                      : 0,
                  child: Container(
                      margin: EdgeInsets.only(top:  PlatformRelativeSize.blockVertical*1.16),
                      width: double.maxFinite,
                      child: Text(this.coverData['subText'],
                          style: TextStyle(
                              color: ConfigColor.tikiBlue,
                              fontFamily: "NunitoSans",
                              fontSize:  PlatformRelativeSize.blockVertical*2.09,
                              fontWeight: FontWeight.w600))))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: _calculateAnimation( PlatformRelativeSize.blockVertical*6.98, _controllerValue.value, 0),
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
                          width: PlatformRelativeSize.blockHorizontal*14.5,
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
