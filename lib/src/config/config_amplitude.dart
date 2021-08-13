/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:amplitude_flutter/amplitude.dart';

import 'config_environment.dart';

class ConfigAmplitude {
  static const _prodApiKey = "1899ef0929b6700fffbb438c1df4fe2f";
  static const _testApiKey = "6f52993a138d9209786c76a03c4e25cf";
  static const String _environment = ConfigEnvironment.appEnv;
  static const String _project =
      _environment == ConfigEnvironment.envPublic ? "App" : "App-test";
  static const String _apiKey =
      _environment == ConfigEnvironment.envPublic ? _prodApiKey : _testApiKey;

  static Future<void> init() async {
    Amplitude instance = Amplitude.getInstance(instanceName: _project);
    await instance.init(_apiKey);
    await instance.enableCoppaControl();
    await instance.setUserId(null);
    await instance.trackingSessionEvents(true);
  }

  static Future<void> logEvent(String eventType,
          {Map<String, dynamic>? eventProperties, bool? outOfSession}) async =>
      Amplitude.getInstance(instanceName: _project).logEvent(eventType,
          eventProperties: eventProperties, outOfSession: outOfSession);
}
