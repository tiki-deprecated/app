/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_company/model/api_company_model.dart';
import 'package:app/src/slices/api_company/repository/api_company_repository.dart';
import 'package:app/src/slices/api_company_index/api_company_index_service.dart';
import 'package:app/src/slices/api_company_index/model/api_company_index_model_rsp.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

class ApiCompanyService {
  final ApiCompanyRepository _repository;
  final ApiCompanyIndexService apiCompanyIndexService;

  ApiCompanyService(
      {required this.apiCompanyIndexService, required Database database})
      : this._repository = ApiCompanyRepository(database);

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
    var getCompany = await _repository.getByDomain(domain);
    if (getCompany != null) {
      company.companyId = getCompany.companyId;
      _repository.update(company);
    }
    return _repository.insert(company);
  }

  Future<ApiCompanyModel?> getById(int? companyId) async {
    if (companyId == null) return null;
    var company = await _repository.getById(companyId);
    return company;
  }
}
