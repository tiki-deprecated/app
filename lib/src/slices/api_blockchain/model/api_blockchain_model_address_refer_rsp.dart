/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiBlockchainModelAddressReferRsp extends JsonObject {
  int? count;

  ApiBlockchainModelAddressReferRsp({this.count});

  ApiBlockchainModelAddressReferRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.count = json['count'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'count': count};
}
