/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class AuthModelOtpReq {
  String? email;

  AuthModelOtpReq(this.email);

  AuthModelOtpReq.fromJson(Map<String, dynamic> json) {
    this.email = json['email'];
  }

  Map<String, dynamic> toJson() => {'email': email};
}
