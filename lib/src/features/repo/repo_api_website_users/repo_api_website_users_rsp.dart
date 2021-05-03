/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoApiWebsiteUsersRsp {
  int total;

  RepoApiWebsiteUsersRsp({this.total});

  RepoApiWebsiteUsersRsp.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.total = json['total'];
    }
  }

  Map<String, dynamic> toJson() => {'total': total};
}
