/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

class ApiOAuthModelProvider {
  static const String _defaultRedirectUri = "com.mytiki.app:/oauth";
  late String clientId;
  late String authorizationEndpoint;
  late String tokenEndpoint;
  late String discoveryUrl;
  late String redirectUri;
  late String userInfoEndpoint;
  late List<String>? promptValues;
  late List<String> scopes;

  ApiOAuthModelProvider.fromMap(map) {
    clientId = Platform.isIOS ? map['iosClientId'] : map['androidClientId'];
    authorizationEndpoint = map['authorizationEndpoint'];
    tokenEndpoint = map['tokenEndpoint'];
    redirectUri = map['redirectUrl'] ?? _defaultRedirectUri;
    discoveryUrl = map['discoveryUrl'];
    userInfoEndpoint = map['userinfo_endpoint'];
    promptValues = map['promptValues'] != null
        ? (map['promptValues'] as List).map((item) => item as String).toList()
        : null;
    scopes = map['scopes'] != null
        ? (map['scopes'] as List).map((item) => item as String).toList()
        : List.empty();
  }
}
