/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class AuthModelToken {
  String? bearer;
  String? refresh;
  int? expiresIn;

  AuthModelToken({this.bearer, this.refresh, this.expiresIn});

  AuthModelToken.fromJson(Map<String, dynamic>? json) {
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
