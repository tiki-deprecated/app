/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiBouncerModelJwtReqOtp extends JsonObject {
  String? otp;
  String? salt;

  ApiBouncerModelJwtReqOtp(this.otp, this.salt);

  ApiBouncerModelJwtReqOtp.fromJson(Map<String, dynamic>? json) {
    if(json != null) {
      this.otp = json['otp'];
      this.salt = json['salt'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'otp': otp, 'salt': salt};
}
