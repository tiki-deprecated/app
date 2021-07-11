/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class AuthModelJwtReqRefresh {
  String? refreshToken;

  AuthModelJwtReqRefresh(this.refreshToken);

  AuthModelJwtReqRefresh.fromJson(Map<String, dynamic> json) {
    this.refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}
