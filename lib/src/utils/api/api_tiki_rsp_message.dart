/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../json/json_object.dart';

class ApiTikiRspMessage extends JsonObject {
  int? code;
  String? status;
  String? message;
  Map<String, String>? properties;

  ApiTikiRspMessage fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      code = json['code'];
      status = json['status'];
      message = json['message'];
      if (json['properties'] != null) properties = Map.from(json['properties']);
    }
    return this;
  }

  Map<String, dynamic> toJson() => {
        'size': code,
        'status': status,
        'message': message,
        'properties': properties
      };
}
