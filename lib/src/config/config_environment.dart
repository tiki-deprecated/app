/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ConfigEnvironment {
  static const _propertyEnv = "com.mytiki.app.environment";
  static const envLocal = 'local';
  static const envDevelop = 'develop';
  static const envPublic = 'public';

  static const String appEnv =
      String.fromEnvironment(_propertyEnv, defaultValue: envPublic);

  static const bool isPublic = appEnv == envPublic;

  static const bool isDevelop = appEnv == envDevelop;

  static const bool isLocal = appEnv == envLocal;
}
