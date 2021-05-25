/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoLocalSsOtpModel {
  String? email;
  String? salt;

  RepoLocalSsOtpModel({this.email, this.salt});

  RepoLocalSsOtpModel.fromJson(Map<String, dynamic>? json) {
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
