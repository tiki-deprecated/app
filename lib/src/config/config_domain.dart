/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'config_environment.dart';

class ConfigDomain {
  static const String bouncer =
      ConfigEnvironment.isLocal ? "localhost:10227" : "bouncer.mytiki.com";
  static const String blockchain =
      ConfigEnvironment.isLocal ? "localhost:10252" : "blockchain.mytiki.com";
  static const String signup =
      ConfigEnvironment.isLocal ? "localhost:3000" : "signup.mytiki.com";
  static const String knowledge =
      ConfigEnvironment.isLocal ? "localhost:10544" : "knowledge.mytiki.com";

  static Uri asUri(String authority, String path,
      [Map<String, dynamic>? query]) {
    return ConfigEnvironment.isLocal
        ? Uri.http(authority, path, query)
        : Uri.https(authority, path, query);
  }

  const ConfigDomain();
}
