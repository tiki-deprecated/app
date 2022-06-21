/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/foundation.dart';

class ConfigAmplitude {

  ConfigAmplitude._();

  static const _prodApiKey = "1899ef0929b6700fffbb438c1df4fe2f";
  static const _testApiKey = "6f52993a138d9209786c76a03c4e25cf";
  static const String _project = kDebugMode ? "App-test" : "App";
  static const String _apiKey = kDebugMode ? _testApiKey : _prodApiKey;
  static Amplitude? instance;

  static Future<Amplitude> init() async {
      instance = Amplitude.getInstance(instanceName: _project);
      await instance!.init(_apiKey);
      await instance!.enableCoppaControl();
      await instance!.setUserId(null);
      await instance!.trackingSessionEvents(true);
      return instance!;
  }
}
