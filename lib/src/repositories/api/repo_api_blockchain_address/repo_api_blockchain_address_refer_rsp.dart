/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoApiBlockchainAddressReferRsp {
  int? count;

  RepoApiBlockchainAddressReferRsp({this.count});

  RepoApiBlockchainAddressReferRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.count = json['count'];
    }
  }

  Map<String, dynamic> toJson() => {'count': count};
}
