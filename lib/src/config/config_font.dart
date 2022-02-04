/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConfigFont {
  //Font families
  static const String familyNunitoSans = "NunitoSans";
  static const String familyKoara = "Koara";

  //Font sizes
  static const num sizeHeadline1 = 37.33;
  static const num sizeHeadline2 = 27.51;
  static const num sizeHeadline3 = 19.65;
  static const num sizeHeadline4 = 19.65;
  static const num sizeSubtitle1 = 17.68;
  static const num sizeSubtitle2 = 17.68;
  static const num sizeBody = 13.75;

  //Font styles
  static TextStyle headline1 = TextStyle(
      fontFamily: familyKoara,
      fontWeight: FontWeight.bold,
      fontSize: sizeHeadline1.sp,
      letterSpacing: sizeHeadline1.sp * 0.01);

  static TextStyle headline2 = TextStyle(
      fontFamily: familyKoara,
      fontWeight: FontWeight.bold,
      fontSize: sizeHeadline2.sp,
      letterSpacing: sizeHeadline2.sp * 0.01);

  static TextStyle headline3 = TextStyle(
      fontFamily: familyKoara,
      fontWeight: FontWeight.bold,
      fontSize: sizeHeadline3.sp,
      letterSpacing: sizeHeadline3.sp * 0.01);

  static TextStyle headline4 = TextStyle(
      fontFamily: familyKoara,
      fontWeight: FontWeight.bold,
      fontSize: sizeHeadline4.sp,
      letterSpacing: sizeHeadline4.sp * 0.01);

  static TextStyle subtitle1 = TextStyle(
      fontFamily: familyNunitoSans,
      fontWeight: FontWeight.w800,
      fontSize: sizeSubtitle1.sp);

  static TextStyle subtitle2 = TextStyle(
      fontFamily: familyNunitoSans,
      fontWeight: FontWeight.w800,
      fontSize: sizeSubtitle2.sp);

  static TextStyle body = TextStyle(
      fontFamily: familyNunitoSans,
      fontWeight: FontWeight.w600,
      fontSize: sizeBody.sp,
      height: 1.2);
}
