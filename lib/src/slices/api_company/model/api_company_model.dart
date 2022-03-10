/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiCompanyModel extends JsonObject {
  int? companyId;
  String? logo;
  double? securityScore;
  double? breachScore;
  double? sensitivityScore;
  String? domain;
  DateTime? created;
  DateTime? modified;

  ApiCompanyModel(
      {this.companyId,
      this.logo,
      this.securityScore,
      this.domain,
      this.sensitivityScore,
      this.breachScore,
      this.created,
      this.modified});

  ApiCompanyModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      companyId = json['company_id'];
      logo = json['logo'];
      securityScore = json['security_score'];
      breachScore = json['breach_score'];
      sensitivityScore = json['sensitivity_score'];
      domain = json['domain'];
      if (json['modified_epoch'] != null) {
        modified =
            DateTime.fromMillisecondsSinceEpoch(json['modified_epoch']);
      }
      if (json['created_epoch'] != null) {
        created =
            DateTime.fromMillisecondsSinceEpoch(json['created_epoch']);
      }
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'company_id': companyId,
        'logo': logo,
        'security_score': securityScore,
        'breach_score': breachScore,
        'sensitivity_score': sensitivityScore,
        'domain': domain,
        'modified_epoch': modified?.millisecondsSinceEpoch,
        'created_epoch': created?.millisecondsSinceEpoch
      };

  @override
  String toString() {
    return 'ApiCompanyModelLocal{companyId: $companyId, logo: $logo, securityScore: $securityScore, breachScore: $breachScore, sensitivityScore: $sensitivityScore, domain: $domain, created: $created, modified: $modified}';
  }

  ApiCompanyModel.fromDynamic(dynamic company) {
    companyId = company.companyId;
    logo = company.logo;
    securityScore = company.securityScore;
    breachScore = company.breachScore;
    sensitivityScore = company.sensitivityScore;
    domain = company.domain;
    created = company.created;
    modified = company.modified;
  }
}
