/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoWebsiteUsersRsp {
  int total;

  RepoWebsiteUsersRsp({this.total});

  RepoWebsiteUsersRsp.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.total = json['total'];
    }
  }

  Map<String, dynamic> toJson() => {'total': total};
}
