import 'package:app/src/slices/intro_screen/intro_screen_service.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_service.dart';
import 'package:app/src/slices/login_screen/login_screen_service.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';

class AppModelRoutes {
  static var home = TikiScreenService();
  static var login = LoginScreenService();
  static var intro = IntroScreenService();
  static var keys = KeysCreateScreenService();
}
