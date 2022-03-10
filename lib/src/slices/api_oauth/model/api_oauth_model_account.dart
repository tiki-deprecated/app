/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiOAuthModelAccount extends JsonObject {
  int? accountId;
  String? _username;
  String? displayName;
  String? email;
  String? provider;
  String? accessToken;
  int? accessTokenExpiration;
  String? refreshToken;
  int? refreshTokenExpiration;
  int? shouldReconnect;
  DateTime? modified;
  DateTime? created;

  String? get username => _username ?? email;

  set username(String? username) {
    _username = username;
  }

  ApiOAuthModelAccount(
      {this.accountId,
      this.email,
      this.displayName,
      this.provider,
      this.accessToken,
      this.accessTokenExpiration,
      this.refreshToken,
      this.refreshTokenExpiration,
      this.shouldReconnect});

  ApiOAuthModelAccount.fromDynamic(dynamic data, this.provider) {
    email = data.email;
    displayName = data.displayName;
    accessToken = data.token;
    accessTokenExpiration =
        (data.accessTokenExp as DateTime).millisecondsSinceEpoch;
    refreshToken = data.refreshToken;
  }

  ApiOAuthModelAccount.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      accountId = json['account_id'];
      username = json['username'];
      displayName = json['display_name'];
      email = json['email'];
      provider = json['provider'];
      accessToken = json['access_token'];
      accessTokenExpiration = json['access_token_expiration'];
      refreshToken = json['refresh_token'];
      refreshTokenExpiration = json['refresh_token_expiration'];
      shouldReconnect = json['should_reconnect'] ?? 0;
      if (json['modified_epoch'] != null) {
        modified =
            DateTime.fromMillisecondsSinceEpoch(json['modified_epoch']);
      }
      if (json['created_epoch'] != null) {
        created =
            DateTime.fromMillisecondsSinceEpoch(json['created_epoch']);
      }
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'account_id': accountId,
        'username': username,
        'display_name': displayName,
        'email': email,
        'provider': provider,
        'access_token': accessToken,
        'access_token_expiration': accessTokenExpiration,
        'refresh_token': refreshToken,
        'refresh_token_expiration': refreshTokenExpiration,
        'should_reconnect': shouldReconnect,
        'modified_epoch': modified?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch,
        'created_epoch': created?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch
      };
}
