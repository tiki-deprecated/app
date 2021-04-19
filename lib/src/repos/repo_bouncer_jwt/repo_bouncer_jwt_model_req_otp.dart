/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoBouncerJwtModelReqOtp {
  String otp;
  String salt;

  RepoBouncerJwtModelReqOtp(this.otp, this.salt);

  RepoBouncerJwtModelReqOtp.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.otp = json['otp'];
      this.salt = json['salt'];
    }
  }

  Map<String, dynamic> toJson() => {'otp': otp, 'salt': salt};
}
