class ApiCompanyModel {
  int? companyId;
  String? logo;
  double? securityScore;
  double? breachScore;
  double? sensitivityScore;
  String? domain;

  ApiCompanyModel(
      {this.companyId,
      this.logo,
      this.securityScore,
      this.domain,
      this.sensitivityScore,
      this.breachScore});

  ApiCompanyModel.fromMap(companyMap)
      : companyId = companyMap['company_id'],
        logo = companyMap['logo'],
        securityScore = companyMap['security_score'],
        breachScore = companyMap['breachScore'],
        sensitivityScore = companyMap['sensitivityScore'],
        domain = companyMap['domain'];

  Map<String, dynamic> toMap() {
    return {
      'company_id': this.companyId,
      'logo': this.logo,
      'security_score': this.securityScore,
      'breach_score': this.breachScore,
      'sensitivity_score': sensitivityScore,
      'domain': this.domain,
    };
  }

  @override
  String toString() {
    var str = '''ApiCompanyModel{ 
      companyId : $companyId, 
      logo : $logo, 
      securityScore : $securityScore,
      security_score : $securityScore,
      breach_score : $breachScore,
      sensitivityScore : $sensitivityScore, 
      domain : $domain, 
      }''';
    return str;
  }
}
