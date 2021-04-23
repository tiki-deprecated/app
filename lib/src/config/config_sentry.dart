/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/config/config_environment.dart';

class ConfigSentry {
  static const String dsn = ConfigEnvironment.isPublic
      ? "https://8074e92e5fc04829b519f700e3295fd2@o564671.ingest.sentry.io/5705532"
      : "";
  static const String environment = ConfigEnvironment.appEnv;

  const ConfigSentry();
}
