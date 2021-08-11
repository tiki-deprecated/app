/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../../utils/api/helper_api_auth.dart';
import '../../utils/api/helper_api_rsp.dart';
import '../../utils/api/helper_api_utils.dart';
import '../api_company/repository/api_company_repository_index.dart';
import '../api_company/repository/api_company_repository_local.dart';
import 'model/api_company_model_index.dart';
import 'model/api_company_model_local.dart';

class ApiCompanyService {
  final HelperApiAuth helperApiAuth;
  final ApiCompanyRepositoryLocal _repositoryLocal;

  ApiCompanyService({required Database database, required this.helperApiAuth})
      : this._repositoryLocal = ApiCompanyRepositoryLocal(database);

  Future<ApiCompanyModelLocal?> upsert(String domain) async {
    if (domain.isNotEmpty) {
      ApiCompanyModelLocal? local = await _repositoryLocal.getByDomain(domain);
      if (local == null) {
        HelperApiRsp<ApiCompanyModelIndex> indexRsp = await fetch(domain);
        if (HelperApiUtils.isOk(indexRsp.code))
          return _repositoryLocal.insert(ApiCompanyModelLocal(
            domain: domain,
            logo: indexRsp.data.about?.logo,
            securityScore: indexRsp.data.score?.securityScore,
            breachScore: indexRsp.data.score?.securityScore,
            sensitivityScore: indexRsp.data.score?.securityScore,
          ));
      } else if (local.modified == null ||
          local.securityScore == null ||
          local.modified!
              .isBefore(DateTime.now().subtract(Duration(days: 30)))) {
        HelperApiRsp<ApiCompanyModelIndex> indexRsp = await fetch(domain);
        if (HelperApiUtils.is2xx(indexRsp.code))
          return _repositoryLocal.update(ApiCompanyModelLocal(
            companyId: local.companyId,
            domain: domain,
            logo: indexRsp.data.about?.logo,
            securityScore: indexRsp.data.score?.securityScore,
            breachScore: indexRsp.data.score?.securityScore,
            sensitivityScore: indexRsp.data.score?.securityScore,
          ));
      } else
        return local;
    }
  }

  Future<ApiCompanyModelLocal?> getById(int? companyId) async {
    if (companyId == null) return null;
    var company = await _repositoryLocal.getById(companyId);
    return company;
  }

  Future<HelperApiRsp<ApiCompanyModelIndex>> fetch(String domain) async =>
      await helperApiAuth.proxy(
          () => ApiCompanyRepositoryIndex.find(helperApiAuth.bearer, domain));
}
