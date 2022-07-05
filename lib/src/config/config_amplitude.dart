/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/foundation.dart';

class ConfigAmplitude {
  ConfigAmplitude._();

  static const _prodApiKey = "ec9c60695464bb3c0af6ce7b76d8280c";
  static const _testApiKey = "afba707e002643a678747221206c9605";
  static const String _project = kDebugMode ? "Develop" : "App";
  static const String _apiKey = kDebugMode ? _testApiKey : _prodApiKey;

  static Amplitude get instance =>
      Amplitude.getInstance(instanceName: _project);

  static Future<Amplitude> init() async {
    await Amplitude.getInstance(instanceName: _project).init(_apiKey);
    await Amplitude.getInstance(instanceName: _project).enableCoppaControl();
    await Amplitude.getInstance(instanceName: _project).setUserId(null);
    await Amplitude.getInstance(instanceName: _project)
        .trackingSessionEvents(true);
    return instance;
  }
}
