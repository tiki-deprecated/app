/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoBlockchainAddressModelRsp {
  String address;
  DateTime issued;
  String refer;

  RepoBlockchainAddressModelRsp({this.address, this.issued, this.refer});

  RepoBlockchainAddressModelRsp.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.address = json['address'];
      this.issued = DateTime.parse(json['issued']);
      this.refer = json['refer'];
    }
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'issued': issued?.toUtc()?.toIso8601String(),
        'refer': refer
      };
}
