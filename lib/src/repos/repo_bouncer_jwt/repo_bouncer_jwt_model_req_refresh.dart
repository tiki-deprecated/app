/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoBouncerJwtModelReqRefresh {
  String refreshToken;

  RepoBouncerJwtModelReqRefresh(this.refreshToken);

  RepoBouncerJwtModelReqRefresh.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.refreshToken = json['refreshToken'];
    }
  }

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}
