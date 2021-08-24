class ApiAuthServiceAccountModel {
  int? accountId;
  String? username;
  String? accessToken;
  int? accessTokenExpiration;
  String? refreshToken;
  int? refreshTokenExpiration;
  DateTime? modified;
  DateTime? created;
  int? shouldReconnect;

  ApiAuthServiceAccountModel(
      {this.accountId,
      this.username,
      this.accessToken,
      this.accessTokenExpiration,
      this.refreshToken,
      this.refreshTokenExpiration,
      this.shouldReconnect});

  ApiAuthServiceAccountModel.fromMap(map) {
    this.accountId = map['account_id'];
    this.username = map['username'];
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
        'access_token': accessToken,
        'access_token_expiration': accessTokenExpiration,
        'refreshToken': refreshToken,
        'refresh_token_expiration': refreshTokenExpiration,
        'should_reconnect': shouldReconnect,
        'modified_epoch': modified?.millisecondsSinceEpoch,
        'created_epoch': created?.millisecondsSinceEpoch
      };
}
