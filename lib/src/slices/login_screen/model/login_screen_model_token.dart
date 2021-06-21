/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class LoginScreenModelToken {
  String? bearer;
  String? refresh;
  int? expiresIn;

  LoginScreenModelToken({this.bearer, this.refresh, this.expiresIn});

  LoginScreenModelToken.fromJson(Map<String, dynamic>? json) {
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
