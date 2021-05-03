/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoApiBlockchainAddressReq {
  String dataKey;
  String signKey;
  String referFrom;

  RepoApiBlockchainAddressReq(this.dataKey, this.signKey, {this.referFrom});

  RepoApiBlockchainAddressReq.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.dataKey = json['dataKey'];
      this.signKey = json['signKey'];
      this.referFrom = json['referFrom'];
    }
  }

  Map<String, dynamic> toJson() =>
      {'dataKey': dataKey, 'signKey': signKey, 'referFrom': referFrom};
}
