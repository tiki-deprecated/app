/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class AppModelUser {
  String? email;
  String? address;
  bool? isLoggedIn;
  String? code;
  Uri? referral;

  AppModelUser({this.email, this.address, this.isLoggedIn, this.referral});

  AppModelUser.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.email = json['email'];
      this.address = json['address'];
      this.isLoggedIn = json['isLoggedIn'];
      this.referral =
          json['referral'] == null ? null : Uri.parse(json['referral']);
      this.code = json['code'] == null ? null : json['code'];
    }
  }

  Map<String, dynamic> toJson() =>
      {
        'email': email,
        'address': address,
        'isLoggedIn': isLoggedIn,
        'referral': referral == null ? null : referral.toString(),
        'code': code
      };
}
