/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoBouncerJwtModelReq {
  String otp;
  String salt;

  RepoBouncerJwtModelReq(this.otp, this.salt);

  RepoBouncerJwtModelReq.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.otp = json['otp'];
      this.salt = json['salt'];
    }
  }

  Map<String, dynamic> toJson() => {'otp': otp, 'salt': salt};
}
