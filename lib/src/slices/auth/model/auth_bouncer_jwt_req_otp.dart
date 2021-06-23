/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class AuthModelJwtReqOtp {
  String? otp;
  String? salt;

  AuthModelJwtReqOtp(this.otp, this.salt);

  AuthModelJwtReqOtp.fromJson(Map<String, dynamic> json) {
    this.otp = json['otp'];
    this.salt = json['salt'];
  }

  Map<String, dynamic> toJson() => {'otp': otp, 'salt': salt};
}
