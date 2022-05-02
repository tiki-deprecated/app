/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../utils/json/json_object.dart';

class ApiShortCodeModelClaim extends JsonObject {
  String? code;
  String? address;

  ApiShortCodeModelClaim({this.code, this.address});

  ApiShortCodeModelClaim.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      code = json['code'];
      address = json['address'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'address': address, 'code': code};
}
