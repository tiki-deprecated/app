/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../../utils/json/json_object.dart';

class ApiKnowledgeModelCompanyAbout extends JsonObject {
  String? domain;
  String? name;
  String? description;
  String? logo;
  String? url;
  String? address;
  String? phone;

  ApiKnowledgeModelCompanyAbout(
      {this.domain,
      this.name,
      this.description,
      this.logo,
      this.url,
      this.address,
      this.phone});

  ApiKnowledgeModelCompanyAbout.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      domain = json['domain'];
      name = json['name'];
      description = json['description'];
      logo = json['logo'];
      url = json['url'];
      address = json['address'];
      phone = json['phone'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'domain': domain,
        'name': name,
        'description': description,
        'logo': logo,
        'url': url,
        'address': address,
        'phone': phone
      };
}
