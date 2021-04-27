/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoLocalSsTokenModel {
  String bearer;
  String refresh;

  RepoLocalSsTokenModel({this.bearer, this.refresh});

  RepoLocalSsTokenModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.bearer = json['bearer'];
      this.refresh = json['refresh'];
    }
  }

  Map<String, dynamic> toJson() => {
        'bearer': bearer,
        'refresh': refresh,
      };
}
