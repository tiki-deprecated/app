import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:flutter/material.dart';

class AppModelRoutes {
  static Widget home = TikiScreenService().getUI();
  static Widget login = TikiScreenService().getUI();
  static Widget intro = TikiScreenService().getUI();
  static Widget keys = TikiScreenService().getUI();
}
