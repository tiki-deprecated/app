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

  AppModelCurrent? current;
  AppModelUser? user;

  get isLoggedIn =>
      user != null &&
      user!.isLoggedIn != null &&
      user!.isLoggedIn! &&
      user!.keys != null &&
      user!.keys!.address != null &&
      user!.keys!.signPrivateKey != null &&
      user!.keys!.dataPrivateKey != null &&
      user!.token != null &&
      user!.token!.refresh != null;
}
