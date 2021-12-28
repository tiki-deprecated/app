/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../../utils/api/helper_api_auth.dart';
import '../../utils/api/helper_api_rsp.dart';
import '../api_company/repository/api_company_repository.dart';
import '../api_knowledge/api_knowledge_service.dart';
import '../api_knowledge/model/company/api_knowledge_model_company.dart';
import 'model/api_company_model.dart';

class ApiCompanyService {
  final HelperApiAuth helperApiAuth;
  final ApiCompanyRepository _repositoryLocal;
  final ApiKnowledgeService _apiKnowledgeService;

  ApiCompanyService(
      {required Database database,
      required this.helperApiAuth,
      required ApiKnowledgeService apiKnowledgeService})
      : this._repositoryLocal = ApiCompanyRepository(database),
        this._apiKnowledgeService = apiKnowledgeService;

  Future<ApiCompanyModel?> upsert(String domain) async {
    if (domain.isNotEmpty) {
      ApiCompanyModel? local = await _repositoryLocal.getByDomain(domain);
      if (local == null) {
        HelperApiRsp<ApiKnowledgeModelCompany> indexRsp =
            await _apiKnowledgeService.getCompany(domain);
        if (HttppUtils.is2xx(indexRsp.code))
          return _repositoryLocal.insert(ApiCompanyModel(
            domain: domain,
            logo: indexRsp.data.about?.logo,
            securityScore: indexRsp.data.score?.securityScore,
            breachScore: indexRsp.data.score?.breachScore,
            sensitivityScore: indexRsp.data.score?.sensitivityScore,
          ));
      } else if (local.modified == null ||
          local.securityScore == null ||
          local.modified!
              .isBefore(DateTime.now().subtract(Duration(days: 30)))) {
        HelperApiRsp<ApiKnowledgeModelCompany> indexRsp =
            await _apiKnowledgeService.getCompany(domain);
        if (HttppUtils.is2xx(indexRsp.code))
          return _repositoryLocal.update(ApiCompanyModel(
              companyId: local.companyId,
              domain: domain,
              logo: indexRsp.data.about?.logo,
              securityScore: indexRsp.data.score?.securityScore,
              breachScore: indexRsp.data.score?.breachScore,
              sensitivityScore: indexRsp.data.score?.sensitivityScore,
              created: local.created,
              modified: local.modified));
      } else
        return local;
    }
  }

  Future<ApiCompanyModel?> getById(int? companyId) async {
    if (companyId == null) return null;
    var company = await _repositoryLocal.getById(companyId);
    return company;
  }
}
