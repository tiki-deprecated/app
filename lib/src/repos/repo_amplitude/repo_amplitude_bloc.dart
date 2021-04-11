/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:amplitude_flutter/amplitude.dart';
import 'package:app/src/utilities/utility_functions.dart';

class RepoAmplitudeBloc {
  static final String _instanceNamePublic = 'App';
  static final String _instanceNameTest = 'App-Test';
  static final String _apiKeyPublic = '1899ef0929b6700fffbb438c1df4fe2f';
  static final String _apiKeyTest = '6f52993a138d9209786c76a03c4e25cf';
  final Amplitude _amplitude;
  Map<String, dynamic> _userProperties;

  RepoAmplitudeBloc()
      : _amplitude = Amplitude.getInstance(
            instanceName: appEnv == appEnvPublic
                ? _instanceNamePublic
                : _instanceNameTest);

  Future<void> init() async {
    await _amplitude.init(appEnv == appEnvPublic ? _apiKeyPublic : _apiKeyTest);
    await _amplitude
        .enableCoppaControl(); //disables IDFA, IDFV, city, IP address and location tracking
    await _amplitude.setUserId(null);
  }

  Future<void> cycleId() async {
    await _amplitude.regenerateDeviceId();
  }

  Future<void> event(String type, {Map<String, dynamic> properties}) async {
    await _amplitude.logEvent(type, eventProperties: properties);
  }

  Future<void> updateUser(Map<String, dynamic> properties) async {
    _userProperties.addAll(properties);
    await _amplitude.setUserProperties(_userProperties);
  }
}
