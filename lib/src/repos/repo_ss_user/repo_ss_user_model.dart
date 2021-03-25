/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoSSUserModel {
  String email;
  String uuid;
  bool loggedIn = false;
  String bearer;
  String refresh;

  RepoSSUserModel(
      {this.email,
      this.uuid,
      this.loggedIn = false,
      this.bearer,
      this.refresh});

  RepoSSUserModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.email = json['email'];
      this.uuid = json['uuid'];
      this.loggedIn = json['loggedIn'];
      this.bearer = json['bearer'];
      this.refresh = json['refrehs'];
    }
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'uuid': uuid,
        'loggedIn': loggedIn,
        'bearer': bearer,
        'refresh': refresh
      };
}
