class ApiCompanyModel {
  int? companyId;
  String? logo;
  double? securityScore;
  String? domain;

  ApiCompanyModel({this.companyId, this.logo, this.securityScore, this.domain});

  ApiCompanyModel.fromMap(companyMap)
      : companyId = companyMap['company_id'],
        logo = companyMap['logo'],
        securityScore = companyMap['security_score'],
        domain = companyMap['domain'];

  Map<String, dynamic> toMap() {
    return {
      'company_id': this.companyId,
      'logo': this.logo,
      'security_score': this.securityScore,
      'domain': this.domain,
    };
  }

  @override
  String toString() {
    var str = '''ApiCompanyModel{ 
      companyId : $companyId, 
      logo : $logo, 
      securityScore : $securityScore, 
      domain : $domain, 
      }''';
    return str;
  }
}
