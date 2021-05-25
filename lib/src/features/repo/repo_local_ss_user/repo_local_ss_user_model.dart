/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoLocalSsUserModel {
  String? email;
  String? address;
  bool? isLoggedIn;
  Uri? referral;

  RepoLocalSsUserModel(
      {this.email, this.address, this.isLoggedIn, this.referral});

  RepoLocalSsUserModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.email = json['email'];
      this.address = json['address'];
      this.isLoggedIn = json['isLoggedIn'];
      this.referral =
          json['referral'] == null ? null : Uri.parse(json['referral']);
    }
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'address': address,
        'isLoggedIn': isLoggedIn,
        'referral': referral == null ? null : referral.toString()
      };
}
