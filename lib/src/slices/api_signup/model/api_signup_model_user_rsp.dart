/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiSignupModelUserRsp {
  int? total;

  ApiSignupModelUserRsp({this.total});

  ApiSignupModelUserRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.total = json['total'];
    }
  }

  Map<String, dynamic> toJson() => {'total': total};
}
