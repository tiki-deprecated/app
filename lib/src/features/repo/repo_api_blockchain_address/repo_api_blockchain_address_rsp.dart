/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoApiBlockchainAddressRsp {
  String address;
  DateTime issued;

  RepoApiBlockchainAddressRsp({this.address, this.issued});

  RepoApiBlockchainAddressRsp.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.address = json['address'];
      this.issued = DateTime.parse(json['issued']);
    }
  }

  Map<String, dynamic> toJson() =>
      {'address': address, 'issued': issued?.toUtc()?.toIso8601String()};
}
