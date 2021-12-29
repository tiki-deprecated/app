/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiOAuthModelAccount extends JsonObject {
  int? accountId;
  String? username;
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

  ApiOAuthModelAccount(
      {this.accountId,
      this.username,
      this.email,
      this.displayName,
      this.provider,
      this.accessToken,
      this.accessTokenExpiration,
      this.refreshToken,
      this.refreshTokenExpiration,
      this.shouldReconnect});

  ApiOAuthModelAccount.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.accountId = json['account_id'];
      this.username = json['username'];
      this.displayName = json['display_name'];
      this.email = json['email'];
      this.provider = json['provider'];
      this.accessToken = json['access_token'];
      this.accessTokenExpiration = json['access_token_expiration'];
      this.refreshToken = json['refresh_token'];
      this.refreshTokenExpiration = json['refresh_token_expiration'];
      this.shouldReconnect = json['should_reconnect'] ?? 0;
      if (json['modified_epoch'] != null)
        this.modified =
            DateTime.fromMillisecondsSinceEpoch(json['modified_epoch']);
      if (json['created_epoch'] != null)
        this.created =
            DateTime.fromMillisecondsSinceEpoch(json['created_epoch']);
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
