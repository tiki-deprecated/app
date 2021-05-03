/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoLocalSsTokenModel {
  String bearer;
  String refresh;
  int expiresIn;

  RepoLocalSsTokenModel({this.bearer, this.refresh, this.expiresIn});

  RepoLocalSsTokenModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.bearer = json['bearer'];
      this.refresh = json['refresh'];
      this.expiresIn = json['expiresIn'];
    }
  }

  Map<String, dynamic> toJson() => {
        'bearer': bearer,
        'refresh': refresh,
        'expiresIn': expiresIn,
      };
}
