/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiBouncerModelOtpReq extends JsonObject {
  String? email;

  ApiBouncerModelOtpReq(this.email);

  ApiBouncerModelOtpReq.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.email = json['email'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'email': email};
}
