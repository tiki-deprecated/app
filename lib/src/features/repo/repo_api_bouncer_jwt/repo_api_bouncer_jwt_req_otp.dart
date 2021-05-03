/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoApiBouncerJwtReqOtp {
  String otp;
  String salt;

  RepoApiBouncerJwtReqOtp(this.otp, this.salt);

  RepoApiBouncerJwtReqOtp.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.otp = json['otp'];
      this.salt = json['salt'];
    }
  }

  Map<String, dynamic> toJson() => {'otp': otp, 'salt': salt};
}
