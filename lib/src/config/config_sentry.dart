/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sentry_flutter/sentry_flutter.dart';

import 'config_environment.dart';

//TODO setup good exception handling -> https://flutter.dev/docs/testing/errors

class ConfigSentry {
  static const String dsn = ConfigEnvironment.isDevelop ||
          ConfigEnvironment.isLocal
      ? ""
      : "https://8074e92e5fc04829b519f700e3295fd2@o564671.ingest.sentry.io/5705532";
  static const String environment = ConfigEnvironment.appEnv;
  static const SentryLevel levelDebug = SentryLevel.debug;
  static const SentryLevel levelInfo = SentryLevel.info;
  static const SentryLevel levelWarn = SentryLevel.warning;
  static const SentryLevel levelError = SentryLevel.error;
  static const SentryLevel levelFatal = SentryLevel.fatal;

  const ConfigSentry();

  static SentryHttpClient get http => SentryHttpClient();

  static SentryNavigatorObserver get navigatorObserver =>
      SentryNavigatorObserver();

  static Future<SentryId> message(
    String message, {
    SentryLevel? level = levelInfo,
    List<dynamic>? params,
  }) =>
      Sentry.captureMessage(message, level: level, params: params);

  static Future<SentryId> exception(
    dynamic throwable, {
    dynamic stackTrace,
  }) =>
      Sentry.captureException(throwable, stackTrace: stackTrace);
}
