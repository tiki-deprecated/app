/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiBouncerModelJwtRsp extends JsonObject {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;

  ApiBouncerModelJwtRsp(
      {this.accessToken, this.tokenType, this.expiresIn, this.refreshToken});

  ApiBouncerModelJwtRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.accessToken = json['accessToken'];
      this.tokenType = json['tokenType'];
      this.expiresIn = json['expiresIn'];
      this.refreshToken = json['refreshToken'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'tokenType': tokenType,
        'expiresIn': expiresIn,
        'refreshToken': refreshToken
      };
}
