/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiUserModelUser {
  String? email;
  String? address;
  bool? isLoggedIn;
  String? code;

  ApiUserModelUser({this.email, this.address, this.isLoggedIn, this.code});

  ApiUserModelUser.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.email = json['email'];
      this.address = json['address'];
      this.isLoggedIn = json['isLoggedIn'];
      this.code = json['code'] == null ? null : json['code'];
    }
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'address': address,
        'isLoggedIn': isLoggedIn,
        'code': code
      };
}
