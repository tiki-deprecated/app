import 'package:app/src/home/home_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tiki_login/tiki_login.dart';

import 'app.dart';
import 'provide.dart' as provide;
import 'src/config/config_amplitude.dart';
import 'src/config/config_log.dart';
import 'src/config/config_sentry.dart';

Future<void> main() async {
  await _libsInit();
  TikiLogin login = await _loginInit();
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

Future<TikiLogin> _loginInit() async {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Httpp httpp = Httpp(useClient: () => SentryHttpClient());
  HomeService home = HomeService();
  TikiLogin login = TikiLogin(
      httpp: httpp, secureStorage: secureStorage, home: home.presenter);
  home.presenter.inject(() =>
      provide.init(home, login: login, secureStorage: secureStorage, httpp: httpp));
  await login.init();
  return login;
}
