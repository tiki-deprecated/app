/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiKnowledgeModelCompanyAbout {
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
      this.domain = json['domain'];
      this.name = json['name'];
      this.description = json['description'];
      this.logo = json['logo'];
      this.url = json['url'];
      this.address = json['address'];
      this.phone = json['phone'];
    }
  }

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
