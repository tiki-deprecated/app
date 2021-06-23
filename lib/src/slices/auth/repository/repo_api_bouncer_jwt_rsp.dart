/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoApiBouncerJwtRsp {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;

  RepoApiBouncerJwtRsp(
      {this.accessToken, this.tokenType, this.expiresIn, this.refreshToken});

  RepoApiBouncerJwtRsp.fromJson(Map<String, dynamic>? json) {
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
