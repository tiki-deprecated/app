/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoBlockchainAddressModelRsp {
  String address;
  DateTime issued;

  RepoBlockchainAddressModelRsp({this.address, this.issued});

  RepoBlockchainAddressModelRsp.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.address = json['address'];
      this.issued = DateTime.parse(json['issued']);
    }
  }

  Map<String, dynamic> toJson() =>
      {'address': address, 'issued': issued?.toUtc()?.toIso8601String()};
}
