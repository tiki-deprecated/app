import 'package:app/src/slices/api_company/model/api_company_model.dart';
import 'package:app/src/slices/api_company/repository/api_company_repository.dart';
import 'package:app/src/slices/api_company_index/api_company_index_service.dart';
import 'package:app/src/slices/api_company_index/model/api_company_index_model_rsp.dart';

class ApiCompanyService {
  final ApiCompanyIndexService apiCompanyIndexService;

  ApiCompanyService(this.apiCompanyIndexService);

  Future<ApiCompanyModel> createOrUpdate(String domain) async {
    ApiCompanyIndexModelRsp companyIndexData =
        (await apiCompanyIndexService.find(domain)).data;
    ApiCompanyModel company = ApiCompanyModel(
      domain: domain,
      logo: companyIndexData.about?.logo,
      securityScore: companyIndexData.score?.securityScore,
      breachScore: companyIndexData.score?.securityScore,
      sensitivityScore: companyIndexData.score?.securityScore,
    );
    var getCompany = await ApiCompanyRepository().get(company);
    var dbCompany = getCompany.length > 0
        ? ApiCompanyRepository().update(company)
        : ApiCompanyRepository().insert(company);
    return dbCompany;
  }

  Future<ApiCompanyModel> getById(int? companyId) async {
    ApiCompanyModel company = ApiCompanyModel(companyId: companyId);
    return (await ApiCompanyRepository().get(company))[0];
  }
}
