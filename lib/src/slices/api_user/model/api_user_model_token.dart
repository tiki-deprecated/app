/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiUserModelToken extends JsonObject {
  String? bearer;
  String? refresh;
  DateTime? expires;

  ApiUserModelToken({this.bearer, this.refresh, this.expires});

  ApiUserModelToken.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.bearer = json['bearer'];
      this.refresh = json['refresh'];
      if (json['expires_epoch'] != null)
        this.expires =
            DateTime.fromMillisecondsSinceEpoch(json['expires_epoch']);
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'bearer': bearer,
        'refresh': refresh,
        'expires_epoch': expires?.millisecondsSinceEpoch,
      };
}
