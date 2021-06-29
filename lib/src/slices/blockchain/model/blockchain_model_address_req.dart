/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoApiBlockchainAddressReq {
  String? dataKey;
  String? signKey;
  String? referFrom;

  RepoApiBlockchainAddressReq(this.dataKey, this.signKey, {this.referFrom});

  RepoApiBlockchainAddressReq.fromJson(Map<String, dynamic> json) {
    this.dataKey = json['dataKey'];
    this.signKey = json['signKey'];
  }

  Map<String, dynamic> toJson() => {'dataKey': dataKey, 'signKey': signKey};
}
