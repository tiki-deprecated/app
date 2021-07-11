/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoModelAddressReferRsp {
  int? count;

  RepoModelAddressReferRsp({this.count});

  RepoModelAddressReferRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.count = json['count'];
    }
  }

  Map<String, dynamic> toJson() => {'count': count};
}
