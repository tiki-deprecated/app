/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class HelperApiRspMessage {
  int code;
  String status;
  String message;
  Map<String, String> properties;

  HelperApiRspMessage({this.code, this.status, this.message, this.properties});

  HelperApiRspMessage.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.code = json['code'];
      this.status = json['status'];
      this.message = json['message'];
      this.properties = json['properties'];
    }
  }

  Map<String, dynamic> toJson() => {
        'size': code,
        'status': status,
        'message': message,
        'properties': properties
      };
}
