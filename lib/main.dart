import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// The dart entrypoint
///
/// Initializes the app execution and configurates its dependencies.
/// [WidgetsFlutterBinding.ensureInitialized] waits until widget tree binding is initialized to configure the app.
/// [Firebase.initializeApp] initializes Firebase.
/// [FlutterSecureStorage] initializes the secure storage that will keep the keys.
/// [HelperLogin] handles login state.
/// [SystemChrome] uses setPreferedOrientation to keep app in portrait
/// [TikiAnalytics] enables in-app anonymous analytics with Amplitude.
/// [TikiDatabase] SQLite connector
/// [SentryFlutter] enables Sentry.io monitoring in the app.
Future<void> main() async {
  await initializeDependencies();
  SentryFlutter.init(
      (options) async => options
        ..dsn = ConfigSentry.dsn
        ..environment = ConfigSentry.environment
        ..release = (await PackageInfo.fromPlatform()).version
        ..sendDefaultPii = false,
      appRunner: () => runApp(AppService().getUI()));
}

Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  TikiAnalytics.getLogger();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Firebase.initializeApp();
  await TikiDatabase.instance!.database;
}
