import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';

import 'app_model_current.dart';
import 'app_model_user.dart';

class AppModel {
  static const String title = "TIKI";
  static const String fontFamily = "NunitoSans";
  static const Color displayColor = ConfigColor.mardiGras;
  static const Color bodyColor = ConfigColor.mardiGras;

  Map<String, WidgetBuilder>? routes;

  late AppModelCurrent? current;
  late AppModelUser? user;
}
