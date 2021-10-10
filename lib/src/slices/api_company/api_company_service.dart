/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../../utils/api/helper_api_auth.dart';
import '../../utils/api/helper_api_rsp.dart';
import '../../utils/api/helper_api_utils.dart';
import '../api_company/repository/api_company_repository_local.dart';
import '../api_knowledge/api_knowledge_service.dart';
import '../api_knowledge/model/company/api_knowledge_model_company.dart';
import 'model/api_company_model_local.dart';

class ApiCompanyService {
  final HelperApiAuth helperApiAuth;
  final ApiCompanyRepositoryLocal _repositoryLocal;
  final ApiKnowledgeService _apiKnowledgeService;

  ApiCompanyService(
      {required Database database,
      required this.helperApiAuth,
      required ApiKnowledgeService apiKnowledgeService})
      : this._repositoryLocal = ApiCompanyRepositoryLocal(database),
        this._apiKnowledgeService = apiKnowledgeService;

  Future<ApiCompanyModelLocal?> upsert(String domain) async {
    if (domain.isNotEmpty) {
      ApiCompanyModelLocal? local = await _repositoryLocal.getByDomain(domain);
      if (local == null) {
        HelperApiRsp<ApiKnowledgeModelCompany> indexRsp =
            await _apiKnowledgeService.getCompany(domain);
        if (HelperApiUtils.is2xx(indexRsp.code))
          return _repositoryLocal.insert(ApiCompanyModelLocal(
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
        if (HelperApiUtils.is2xx(indexRsp.code))
          return _repositoryLocal.update(ApiCompanyModelLocal(
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

  Future<ApiCompanyModelLocal?> getById(int? companyId) async {
    if (companyId == null) return null;
    var company = await _repositoryLocal.getById(companyId);
    return company;
  }
}
