/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoApiBouncerJwtReqRefresh {
  String? refreshToken;

  RepoApiBouncerJwtReqRefresh(this.refreshToken);

  RepoApiBouncerJwtReqRefresh.fromJson(Map<String, dynamic> json) {
    this.refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}
