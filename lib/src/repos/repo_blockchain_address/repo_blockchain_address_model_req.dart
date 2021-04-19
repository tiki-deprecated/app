/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoBlockchainAddressModelReq {
  String dataKey;
  String signKey;
  String referFrom;

  RepoBlockchainAddressModelReq(this.dataKey, this.signKey, {this.referFrom});

  RepoBlockchainAddressModelReq.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.dataKey = json['dataKey'];
      this.signKey = json['signKey'];
      this.referFrom = json['referFrom'];
    }
  }

  Map<String, dynamic> toJson() =>
      {'dataKey': dataKey, 'signKey': signKey, 'referFrom': referFrom};
}
