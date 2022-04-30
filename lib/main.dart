import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tiki_login/tiki_login.dart';

import 'app.dart';
import 'inject.dart';
import 'src/config/config_amplitude.dart';
import 'src/config/config_log.dart';
import 'src/config/config_sentry.dart';
import 'src/slices/home_screen/home_screen_service.dart';
import 'src/utils/upgrade.dart';

Future<void> main() async {
  await _libsInit();
  TikiLogin login = await _initializeLogin();
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

Future<void> _libsInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ConfigLog();
  await ConfigAmplitude.init();
  await Firebase.initializeApp();
}

Future<TikiLogin> _initializeLogin() async {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Httpp httpp = Httpp(useClient: () => SentryHttpClient());
  HomeScreenService home = HomeScreenService();
  TikiLogin login = TikiLogin(
      httpp: httpp,
      secureStorage: secureStorage,
      home: home.presenter);
  login.onLogin('Upgrade', () => upgrade(login, httpp));
  home.presenter.inject(
      () => provide(login: login, secureStorage: secureStorage, httpp: httpp));
  await login.init();
  return login;
}

