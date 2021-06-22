import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';

import 'app_model_current.dart';
import 'app_model_routes.dart';
import 'app_model_user.dart';

class AppModel {

  static const String title = "TIKI";
  static const String fontFamily = "NunitoSans";
  static const Color displayColor = ConfigColor.mardiGras;
  static const Color bodyColor = ConfigColor.mardiGras;

  AppModelRoutes routes = AppModelRoutes();

  late AppModelCurrent? current;
  late AppModelUser? user;
}
