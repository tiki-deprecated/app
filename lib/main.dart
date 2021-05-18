import 'package:app/src/utils/analytics/tiki_analytics.dart';
import 'package:app/src/utils/helper/helper_log_in.dart';
import 'package:app/src/utils/migrate/migrate_0_to_001/migrate_0_to_001.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/app.dart';
import 'src/config/config_sentry.dart';

/// The dart entrypoint
///
/// Initializes the app execution and configurates its dependencies.
/// [WidgetsFlutterBinding.ensureInitialized] waits until widget tree binding is initialized to configure the app.
/// [Firebase.initializeApp] initializes Firebase.
/// [FlutterSecureStorage] initializes the secure storage that will keep the keys.
/// [HelperLogin] handles login state.
/// [Migrate0to001] is a helper class to move old accounts to the new Secure Storage system. It will be removed in 0.0.9.
/// [TikiAnalytics] enables in-app anonymous analytics with Amplitude.
/// [SentryFlutter] enables Sentry.io monitoring in the app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TikiAnalytics.getLogger();
  await Firebase.initializeApp();
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  HelperLogIn helperLogIn = HelperLogIn.auto(secureStorage);
  await Migrate0to001(secureStorage).migrate();
  await helperLogIn.load();
  SentryFlutter.init(
      (options) async => options
        ..dsn = ConfigSentry.dsn
        ..environment = ConfigSentry.environment
        ..release = (await PackageInfo.fromPlatform()).version
        ..sendDefaultPii = false,
      appRunner: () => runApp(App(helperLogIn)));
}
