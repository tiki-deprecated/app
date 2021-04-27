/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'config_environment.dart';

class ConfigDomain {
  static const String bouncer =
      ConfigEnvironment.isPublic ? "bouncer.mytiki.com" : "localhost:10227";
  static const String blockchain =
      ConfigEnvironment.isPublic ? "blockchain.mytiki.com" : "localhost:10252";
  static const String website =
      ConfigEnvironment.isPublic ? "api.mytiki.com" : "localhost:3000";

  static Uri asUri(String authority, String unencodedPath,
      [Map<String, dynamic> queryParameters]) {
    return ConfigEnvironment.isPublic
        ? Uri.https(authority, unencodedPath, queryParameters)
        : Uri.http(authority, unencodedPath, queryParameters);
  }

  const ConfigDomain();
}
