/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../utils/json/json_object.dart';

class ApiShortCodeModelRsp extends JsonObject {
  String? code;

  ApiShortCodeModelRsp({this.code});

  ApiShortCodeModelRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.code = json['code'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'code': code};
}
