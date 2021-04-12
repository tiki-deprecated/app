/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoBlockchainAddressModelReq {
  String dataKey;
  String signKey;

  RepoBlockchainAddressModelReq(this.dataKey, this.signKey);

  RepoBlockchainAddressModelReq.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.dataKey = json['dataKey'];
      this.signKey = json['signKey'];
    }
  }

  Map<String, dynamic> toJson() => {'dataKey': dataKey, 'signKey': signKey};
}
