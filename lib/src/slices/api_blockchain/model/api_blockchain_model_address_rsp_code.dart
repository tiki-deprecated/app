/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiBlockchainModelAddressRspCode {
  String? code;

  ApiBlockchainModelAddressRspCode({this.code});

  ApiBlockchainModelAddressRspCode.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.code = json['code'];
    }
  }

  Map<String, dynamic> toJson() => {'address': code};
}
