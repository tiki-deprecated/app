/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiBouncerModelJwtReqRefresh extends JsonObject {
  String? refreshToken;

  ApiBouncerModelJwtReqRefresh(this.refreshToken);

  ApiBouncerModelJwtReqRefresh.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.refreshToken = json['refreshToken'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}
