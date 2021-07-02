/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class AuthModelOtp {
  String? email;
  String? salt;

  AuthModelOtp({this.email, this.salt});

  AuthModelOtp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.email = json['email'];
      this.salt = json['salt'];
    }
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'salt': salt,
      };
}
