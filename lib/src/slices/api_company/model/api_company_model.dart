class ApiCompanyModel {
  final int companyId;
  final String logo;
  final int securityScore;
  final String domain;

  ApiCompanyModel(
      {required this.companyId,
      required this.logo,
      required this.securityScore,
      required this.domain});
}
