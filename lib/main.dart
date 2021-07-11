import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/config/config_sentry.dart';
import 'src/slices/app/app_service.dart';

Future<void> main() async {
  AppService appService = AppService();
  await initializeDependencies(appService);
  SentryFlutter.init(
      (options) async => options
        ..dsn = ConfigSentry.dsn
        ..environment = ConfigSentry.environment
        ..release = (await PackageInfo.fromPlatform()).version
        ..sendDefaultPii = false,
      appRunner: () => runApp(appService.getUI()));
}

Future<void> initializeDependencies(AppService appService) async {
  WidgetsFlutterBinding.ensureInitialized();
  /*AnalyticsService.getLogger();*/
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Firebase.initializeApp();
  /*await DatabaseRepository.instance!.database;*/
  //await appService.load();
}
