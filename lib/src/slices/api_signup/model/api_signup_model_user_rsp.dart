/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiSignupModelUserRsp extends JsonObject {
  int? total;

  ApiSignupModelUserRsp({this.total});

  ApiSignupModelUserRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.total = json['total'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'total': total};
}
