/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class BlockchainModelAddressReq {
  String? dataKey;
  String? signKey;
  String? referFrom;

  BlockchainModelAddressReq(this.dataKey, this.signKey, {this.referFrom});

  BlockchainModelAddressReq.fromJson(Map<String, dynamic> json) {
    this.dataKey = json['dataKey'];
    this.signKey = json['signKey'];
  }

  Map<String, dynamic> toJson() => {'dataKey': dataKey, 'signKey': signKey};
}
