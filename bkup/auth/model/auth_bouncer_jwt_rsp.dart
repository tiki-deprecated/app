/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class AuthBouncerJwtRsp {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;

  AuthBouncerJwtRsp(
      {this.accessToken, this.tokenType, this.expiresIn, this.refreshToken});

  AuthBouncerJwtRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.accessToken = json['accessToken'];
      this.tokenType = json['tokenType'];
      this.expiresIn = json['expiresIn'];
      this.refreshToken = json['refreshToken'];
    }
  }

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'tokenType': tokenType,
        'expiresIn': expiresIn,
        'refreshToken': refreshToken
      };
}
