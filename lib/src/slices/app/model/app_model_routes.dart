import 'package:app/src/slices/intro_screen/intro_screen_service.dart';
import 'package:app/src/slices/keys_screen/keys_screen_service.dart';
import 'package:app/src/slices/login_screen/login_screen_service.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:flutter/material.dart';

class AppModelRoutes {
  static Widget home = TikiScreenService().getUI();
  static Widget login = LoginScreenService().getUI();
  static Widget intro = IntroScreenService().getUI();
  static Widget keys = KeysScreenService().getUI();
}
