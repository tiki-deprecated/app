/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class AuthModelOtpRsp {
  String? salt;
  DateTime? issued;
  DateTime? expires;

  AuthModelOtpRsp(this.salt, {this.issued, this.expires});

  AuthModelOtpRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.salt = json['salt'];
      this.issued = DateTime.parse(json['issued']);
      this.expires = DateTime.parse(json['expires']);
    }
  }

  Map<String, dynamic> toJson() => {
        'salt': salt,
        'issued': issued?.toUtc().toIso8601String(),
        'expires': expires?.toUtc().toIso8601String()
      };
}