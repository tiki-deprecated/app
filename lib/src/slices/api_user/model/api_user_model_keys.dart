/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiUserModelKeys extends JsonObject {
  String? address;
  String? signPrivateKey;
  String? signPublicKey;
  String? dataPrivateKey;
  String? dataPublicKey;

  ApiUserModelKeys(
      {this.address,
      this.signPrivateKey,
      this.signPublicKey,
      this.dataPrivateKey,
      this.dataPublicKey});

  ApiUserModelKeys.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.address = json['address'];
      this.signPrivateKey = json['signPrivateKey'];
      this.signPublicKey = json['signPublicKey'];
      this.dataPrivateKey = json['dataPrivateKey'];
      this.dataPublicKey = json['dataPublicKey'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'address': address,
        'signPrivateKey': signPrivateKey,
        'signPublicKey': signPublicKey,
        'dataPrivateKey': dataPrivateKey,
        'dataPublicKey': dataPublicKey,
      };
}
