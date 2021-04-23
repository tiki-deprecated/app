/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ConfigEnvironment {
  static const _propertyEnv = "com.mytiki.app.environment";
  static const envLocal = 'local';
  static const envPublic = 'public';

  static const String appEnv =
      String.fromEnvironment(_propertyEnv, defaultValue: envLocal);

  static const bool isPublic = appEnv == envPublic;
}
