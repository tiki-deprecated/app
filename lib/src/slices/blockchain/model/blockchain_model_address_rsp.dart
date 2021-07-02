/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class BlockchainModelAddressRsp {
  String? address;
  DateTime? issued;

  BlockchainModelAddressRsp({this.address, this.issued});

  BlockchainModelAddressRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.address = json['address'];
      this.issued = DateTime.parse(json['issued']);
    }
  }

  Map<String, dynamic> toJson() =>
      {'address': address, 'issued': issued?.toUtc().toIso8601String()};
}
