import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
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
        height: _calculateAnimation(maxHeight, _controllerValue.value,
            17.5.h),
        padding: EdgeInsets.only(
            left: 2.9.h,
            top: 1.9.h,
            right: 1.9.h,
            bottom: 1.9.h),
        child: Stack(fit: StackFit.expand, children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: _calculateAnimation(
                      7.h,
                      _controllerValue.value,
                      0),
                  child: Opacity(
                      opacity: 1 - _controllerValue.value,
                      child: this.coverData['topHeader']))),
          Align(
              alignment: Alignment(_controllerValue.value, -1),
              child: Padding(
                  padding: EdgeInsets.only(
                      top: _calculateAnimation(
                          5.8.h,
                          _controllerValue.value,
                          0)),
                  child: HelperImage(this.coverData['image'],
                      width: _calculateAnimation(
                          72.91.w,
                          _controllerValue.value,
                          19.7.h)))),
          Positioned(
              top: 40.h,
              child: Container(
                  height: _calculateAnimation(
                      7.h,
                      _controllerValue.value,
                      0),
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
                                  fontSize:
                                      2.3.sp,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "NunitoSans")))))),
          Padding(
              padding: EdgeInsets.only(
                  top: _calculateAnimation(
                      44.h,
                      _controllerValue.value,
                      2.32.h)),
              child: Align(
                  alignment: Alignment(
                    -_controllerValue.value,
                    -1,
                  ),
                  child: Container(
                      width: _calculateAnimation(
                          MediaQuery.of(context).size.width,
                          _controllerValue.value,
                          41.w),
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              style: TextStyle(
                                  color: Color(0xFF0036B5),
                                  height: 1,
                                  fontFamily: "Koara",
                                  fontSize: _calculateAnimation(
                                      5.23.h,
                                      _controllerValue.value,
                                      2.9.h),
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
                                            5.23.sp,
                                            _controllerValue.value,
                                            2.9.sp),
                                        fontWeight: FontWeight.bold))
                              ]))))),
          Padding(
              padding: EdgeInsets.only(
                top: 59.h,
              ),
              child: Opacity(
                  opacity: _controllerValue.value * 3 <= 1
                      ? 1 - (_controllerValue.value * 3)
                      : 0,
                  child: Container(
                      margin: EdgeInsets.only(
                          top: 1.16.h),
                      width: double.maxFinite,
                      child: Text(this.coverData['subText'],
                          style: TextStyle(
                              color: ConfigColor.tikiBlue,
                              fontFamily: "NunitoSans",
                              fontSize:
                                  2.09.h,
                              fontWeight: FontWeight.w600))))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: _calculateAnimation(
                      6.98.h,
                      _controllerValue.value,
                      0),
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
                          width: 14.5.w,
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
