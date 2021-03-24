/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoSSUserModel {
  String email;
  String uuid;
  bool loggedIn = false;

  RepoSSUserModel({this.email, this.uuid, this.loggedIn = false});

  RepoSSUserModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.email = json['email'];
      this.uuid = json['uuid'];
      this.loggedIn = json['loggedIn'];
    }
  }

  Map<String, dynamic> toJson() =>
      {'email': email, 'uuid': uuid, 'loggedIn': loggedIn};
}
