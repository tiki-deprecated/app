/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiCompanyModelLocal {
  int? companyId;
  String? logo;
  double? securityScore;
  double? breachScore;
  double? sensitivityScore;
  String? domain;

  ApiCompanyModelLocal(
      {this.companyId,
      this.logo,
      this.securityScore,
      this.domain,
      this.sensitivityScore,
      this.breachScore});

  ApiCompanyModelLocal.fromMap(map) {
    this.companyId = map['company_id'];
    this.logo = map['logo'];
    this.securityScore = map['security_score'];
    this.breachScore = map['breach_score'];
    this.sensitivityScore = map['sensitivity_score'];
    this.domain = map['domain'];
  }

  Map<String, dynamic> toMap() => {
        'company_id': companyId,
        'logo': logo,
        'security_score': securityScore,
        'breach_score': breachScore,
        'sensitivity_score': sensitivityScore,
        'domain': domain,
      };

  @override
  String toString() {
    return 'ApiCompanyModel{companyId: $companyId, logo: $logo, securityScore: $securityScore, breachScore: $breachScore, sensitivityScore: $sensitivityScore, domain: $domain}';
  }
}
