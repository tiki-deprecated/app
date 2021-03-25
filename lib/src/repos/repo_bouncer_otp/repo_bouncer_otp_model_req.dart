/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoBouncerOtpModelReq {
  String email;

  RepoBouncerOtpModelReq(this.email);

  RepoBouncerOtpModelReq.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.email = json['email'];
    }
  }

  Map<String, dynamic> toJson() => {'email': email};
}
