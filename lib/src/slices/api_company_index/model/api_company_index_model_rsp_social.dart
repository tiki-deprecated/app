/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiCompanyIndexModelRspSocial {
  String? facebook;
  String? twitter;
  String? linkedin;

  ApiCompanyIndexModelRspSocial({this.facebook, this.twitter, this.linkedin});

  ApiCompanyIndexModelRspSocial.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.facebook = json['facebook'];
      this.twitter = json['twitter'];
      this.linkedin = json['linkedin'];
    }
  }

  Map<String, dynamic> toJson() =>
      {'facebook': facebook, 'twitter': twitter, 'linkedin': linkedin};
}
