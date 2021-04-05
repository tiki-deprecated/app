import 'package:app/src/configs/config_sentry.dart' as ConfigSentry;
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SentryFlutter.init(
      (options) async => options
        ..dsn = ConfigSentry.of(ConfigSentry.dsn)
        ..environment = ConfigSentry.of(ConfigSentry.environment)
        ..release = await version()
        ..sendDefaultPii = false,
      appRunner: () => runApp(App()));
}
