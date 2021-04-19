/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utilities/utility_functions.dart';

const String dsn = 'dsn';
const String environment = 'environment';

T of<T>(String key) {
  return (appEnv == appEnvPublic ? _publicConfig : _localConfig)[key];
}

const Map<String, Object> _publicConfig = {
  dsn:
      'https://8074e92e5fc04829b519f700e3295fd2@o564671.ingest.sentry.io/5705532',
  environment: appEnv
};

const Map<String, Object> _localConfig = {dsn: '', environment: appEnv};
