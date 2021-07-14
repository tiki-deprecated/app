/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiBlockchainModelAddressRsp {
  String? address;
  DateTime? issued;

  ApiBlockchainModelAddressRsp({this.address, this.issued});

  ApiBlockchainModelAddressRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.address = json['address'];
      this.issued = DateTime.parse(json['issued']);
    }
  }

  Map<String, dynamic> toJson() =>
      {'address': address, 'issued': issued?.toUtc().toIso8601String()};
}
