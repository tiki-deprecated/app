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

  ApiOAuthModelProvider.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      clientId = Platform.isIOS ? json['iosClientId'] : json['androidClientId'];
      authorizationEndpoint = json['authorizationEndpoint'];
      tokenEndpoint = json['tokenEndpoint'];
      redirectUri = json['redirectUrl'] ?? _defaultRedirectUri;
      discoveryUrl = json['discoveryUrl'];
      userInfoEndpoint = json['userinfo_endpoint'];
      promptValues = json['promptValues'] != null
          ? (json['promptValues'] as List)
              .map((item) => item as String)
              .toList()
          : null;
      scopes = json['scopes'] != null
          ? (json['scopes'] as List).map((item) => item as String).toList()
          : List.empty();
    }
  }
}
