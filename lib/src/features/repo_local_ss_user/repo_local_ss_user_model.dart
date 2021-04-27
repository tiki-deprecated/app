/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoLocalSsUserModel {
  String email;
  String address;
  bool isLoggedIn;

  RepoLocalSsUserModel({this.email, this.address, this.isLoggedIn});

  RepoLocalSsUserModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.email = json['email'];
      this.address = json['address'];
      this.isLoggedIn = json['isLoggedIn'];
    }
  }

  Map<String, dynamic> toJson() =>
      {'email': email, 'address': address, 'isLoggedIn': isLoggedIn};
}
