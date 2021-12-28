/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiBlockchainModelAddressRspCode extends JsonObject {
  String? code;

  ApiBlockchainModelAddressRspCode({this.code});

  ApiBlockchainModelAddressRspCode.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.code = json['code'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'address': code};
}
