import 'package:app/src/slices/api_company/model/api_company_model.dart';
import 'package:app/src/slices/api_company/repository/api_company_repository.dart';
import 'package:app/src/slices/api_company_index/api_company_index_service.dart';
import 'package:app/src/slices/api_company_index/model/api_company_index_model_rsp.dart';

class ApiCompanyService {
  final ApiCompanyIndexService apiCompanyIndexService;

  ApiCompanyService(this.apiCompanyIndexService);

  Future<ApiCompanyModel?> createOrUpdate(String domain) async {
    if (domain.isEmpty) return null;
    ApiCompanyIndexModelRsp companyIndexData =
        (await apiCompanyIndexService.find(domain)).data;
    ApiCompanyModel company = ApiCompanyModel(
      domain: domain,
      logo: companyIndexData.about?.logo,
      securityScore: companyIndexData.score?.securityScore,
      breachScore: companyIndexData.score?.securityScore,
      sensitivityScore: companyIndexData.score?.securityScore,
    );
    var getCompany = await ApiCompanyRepository().getByDomain(domain);
    if (getCompany != null) {
      company.companyId = getCompany.companyId;
      ApiCompanyRepository().update(company);
    }
    return ApiCompanyRepository().insert(company);
  }

  Future<ApiCompanyModel?> getById(int? companyId) async {
    if (companyId == null) return null;
    var company = await ApiCompanyRepository().getById(companyId);
    return company;
  }
}
