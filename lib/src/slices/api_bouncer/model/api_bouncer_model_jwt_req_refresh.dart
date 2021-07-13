/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiBouncerModelJwtReqRefresh {
  String? refreshToken;

  ApiBouncerModelJwtReqRefresh(this.refreshToken);

  ApiBouncerModelJwtReqRefresh.fromJson(Map<String, dynamic> json) {
    this.refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}
