/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiBlockchainModelAddressReq extends JsonObject {
  String? dataKey;
  String? signKey;

  ApiBlockchainModelAddressReq(this.dataKey, this.signKey);

  ApiBlockchainModelAddressReq.fromJson(Map<String, dynamic> json) {
    this.dataKey = json['dataKey'];
    this.signKey = json['signKey'];
  }

  @override
  Map<String, dynamic> toJson() => {'dataKey': dataKey, 'signKey': signKey};
}
