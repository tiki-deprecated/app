/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiOAuthModelAccount {
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

  ApiOAuthModelAccount.fromMap(map) {
    this.accountId = map['account_id'];
    this.username = map['username'];
    this.displayName = map['display_name'];
    this.email = map['email'];
    this.provider = map['provider'];
    this.accessToken = map['access_token'];
    this.accessTokenExpiration = map['access_token_expiration'];
    this.refreshToken = map['refreshToken'];
    this.refreshTokenExpiration = map['refresh_token_expiration'];
    this.shouldReconnect = map['should_reconnect'] ?? 0;
    if (map['modified_epoch'] != null)
      this.modified =
          DateTime.fromMillisecondsSinceEpoch(map['modified_epoch']);
    if (map['created_epoch'] != null)
      this.created = DateTime.fromMillisecondsSinceEpoch(map['created_epoch']);
  }

  Map<String, dynamic> toMap() => {
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
