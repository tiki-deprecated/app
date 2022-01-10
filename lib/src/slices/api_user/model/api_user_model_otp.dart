/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiUserModelOtp extends JsonObject {
  String? email;
  String? salt;

  ApiUserModelOtp({this.email, this.salt});

  ApiUserModelOtp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.email = json['email'];
      this.salt = json['salt'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'salt': salt,
      };
}
