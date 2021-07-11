/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class BlockchainModelAddressRspCode {
  String? code;

  BlockchainModelAddressRspCode({this.code});

  BlockchainModelAddressRspCode.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.code = json['code'];
    }
  }

  Map<String, dynamic> toJson() => {'address': code};
}
