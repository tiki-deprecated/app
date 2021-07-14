/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiUserModelOtp {
  String? email;
  String? salt;

  ApiUserModelOtp({this.email, this.salt});

  ApiUserModelOtp.fromJson(Map<String, dynamic>? json) {
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
