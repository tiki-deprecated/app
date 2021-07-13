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
  static const String signup =
      ConfigEnvironment.isPublic ? "signup.mytiki.com" : "localhost:3000";

  static Uri asUri(String authority, String path,
      [Map<String, dynamic>? query]) {
    return ConfigEnvironment.isPublic
        ? Uri.https(authority, path, query)
        : Uri.http(authority, path, query);
  }

  const ConfigDomain();
}
