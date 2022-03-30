import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:login/login.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app.dart';
import 'inject.dart';
import 'src/config/config_amplitude.dart';
import 'src/config/config_color.dart';
import 'src/config/config_font.dart';
import 'src/config/config_log.dart';
import 'src/config/config_sentry.dart';
import 'src/slices/home_screen/home_screen_service.dart';
import 'src/utils/upgrade.dart';

Future<void> main() async {
  await _libsInit();
  Login login = await _initializeLogin();
  return SentryFlutter.init(
      (options) async => options
        ..dsn = ConfigSentry.dsn
        ..environment = ConfigSentry.environment
        ..release = (await PackageInfo.fromPlatform()).version
        ..sendDefaultPii = false
        ..diagnosticLevel = SentryLevel.info
        ..sampleRate = 1.0,
      appRunner: () => runApp(App(login.routerDelegate)));
}

Future<void> _libsInit() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ConfigLog();
  await ConfigAmplitude.init();
  await Firebase.initializeApp();
}

Future<Login> _initializeLogin() async {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Httpp httpp = Httpp(useClient: () => SentryHttpClient());
  HomeScreenService home = HomeScreenService();
  Login login = Login(
      style: _style(),
      httpp: httpp,
      secureStorage: secureStorage,
      home: home.presenter);
  login.onLogin('Upgrade', () => upgrade(login, httpp));
  home.presenter.inject(
          () => provide(login: login, secureStorage: secureStorage, httpp: httpp));
  await login.init();
  return login;
}

FlowStyle _style() {
  return FlowStyle(
      intro: ScreenIntroStyle(
          backgroundColor1: ConfigColor.yellow,
          backgroundColor2: ConfigColor.lightYellow,
          backgroundColor3: ConfigColor.lightOrange,
          buttonColor: ConfigColor.tikiPurple,
          buttonTextColor: ConfigColor.white,
          textColor: ConfigColor.tikiPurple,
          skipColor: ConfigColor.tikiBlue,
          dotColor: ConfigColor.white,
          dotColorActive: ConfigColor.tikiPurple,
          textFamily: ConfigFont.familyNunitoSans,
          titleFamily: ConfigFont.familyKoara),
      email: ScreenEmailStyle(
          errorColor: ConfigColor.tikiRed,
          buttonColor: ConfigColor.tikiPurple,
          textColor: ConfigColor.greySeven,
          backgroundColor: ConfigColor.cream,
          buttonTextColor: ConfigColor.white,
          hintColor: ConfigColor.greyFive,
          linkColor: ConfigColor.orange,
          titleColor: ConfigColor.tikiPurple,
          textFamily: ConfigFont.familyNunitoSans,
          titleFamily: ConfigFont.familyKoara),
      inbox: ScreenInboxStyle(
          buttonColor: ConfigColor.orange,
          backgroundColor: ConfigColor.cream,
          textColor: ConfigColor.greySeven,
          titleColor: ConfigColor.tikiPurple,
          textFamily: ConfigFont.familyNunitoSans,
          titleFamily: ConfigFont.familyNunitoSans),
      terms: ScreenTermsStyle(
          backgroundColor: ConfigColor.cream,
          textColor: ConfigColor.greySeven,
          headingColor: ConfigColor.tikiPurple,
          linkColor: ConfigColor.orange,
          titleFamily: ConfigFont.familyKoara,
          textFamily: ConfigFont.familyNunitoSans),
      recover: ModalRecoverStyle(
        textColor: ConfigColor.tikiPurple,
        backgroundColor: ConfigColor.white,
        buttonColor: ConfigColor.orange,
        errorColor: ConfigColor.tikiRed,
        buttonTextColor: ConfigColor.white,
        hintColor: ConfigColor.greySix,
        fontFamily: ConfigFont.familyNunitoSans,
      ));
}
