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
  DateTime? created;
  DateTime? modified;

  ApiCompanyModelLocal(
      {this.companyId,
      this.logo,
      this.securityScore,
      this.domain,
      this.sensitivityScore,
      this.breachScore,
      this.created,
      this.modified});

  ApiCompanyModelLocal.fromMap(map) {
    this.companyId = map['company_id'];
    this.logo = map['logo'];
    this.securityScore = map['security_score'];
    this.breachScore = map['breach_score'];
    this.sensitivityScore = map['sensitivity_score'];
    this.domain = map['domain'];
    if (map['modified_epoch'] != null)
      this.modified =
          DateTime.fromMillisecondsSinceEpoch(map['modified_epoch']);
    if (map['created_epoch'] != null)
      this.created = DateTime.fromMillisecondsSinceEpoch(map['created_epoch']);
  }

  Map<String, dynamic> toMap() => {
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
}
