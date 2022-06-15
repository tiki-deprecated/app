/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:package_info/package_info.dart';

import 'config_environment.dart';

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

  ConfigSentry();

  static Future<void> init() async{
    await SentryFlutter.init(
            (options) async => options
          ..dsn = ConfigSentry.dsn
          ..environment = ConfigSentry.environment
          ..release = (await PackageInfo.fromPlatform()).version
          ..sendDefaultPii = false
          ..diagnosticLevel = SentryLevel.info
          ..sampleRate = 1.0);
  }

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
