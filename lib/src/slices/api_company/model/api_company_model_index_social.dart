/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiCompanyModelIndexSocial {
  String? facebook;
  String? twitter;
  String? linkedin;

  ApiCompanyModelIndexSocial({this.facebook, this.twitter, this.linkedin});

  ApiCompanyModelIndexSocial.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.facebook = json['facebook'];
      this.twitter = json['twitter'];
      this.linkedin = json['linkedin'];
    }
  }

  Map<String, dynamic> toJson() =>
      {'facebook': facebook, 'twitter': twitter, 'linkedin': linkedin};
}
