import 'package:app/src/utils/helper/helper_log_in.dart';
import 'package:app/src/utils/migrate/migrate_0_to_001/migrate_0_to_001.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/app.dart';
import 'src/config/config_sentry.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  HelperLogIn helperLogIn = HelperLogIn.auto(secureStorage);
  await Migrate0to001(secureStorage).migrate();
  await helperLogIn.load();
  await SentryFlutter.init(
      (options) async => options
        ..dsn = ConfigSentry.dsn
        ..environment = ConfigSentry.environment
        ..release = (await PackageInfo.fromPlatform()).version
        ..sendDefaultPii = false,
      appRunner: () => runApp(App(helperLogIn)));
}
