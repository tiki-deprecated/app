/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiUserModelCurrent {
  String? email;

  ApiUserModelCurrent({required this.email});

  ApiUserModelCurrent.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.email = json['email'];
    }
  }

  Map<String, dynamic> toJson() => {'email': email};
}
