/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/auth/model/auth_model_token.dart';
import 'package:app/src/slices/keys/model/api_user_model_keys.dart';

class AppModelUser {
  String? email;
  String? address;
  bool? isLoggedIn;
  String? code;
  Uri? referral;
  KeysModel? keys;
  AuthModelToken? token;

  AppModelUser(
      {this.email, this.address, this.isLoggedIn, this.referral, this.code});

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

  Map<String, dynamic> toJson() => {
        'email': email,
        'address': address,
        'isLoggedIn': isLoggedIn,
        'referral': referral == null ? null : referral.toString(),
        'code': code
      };
}
