/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:logging/logging.dart';
import 'package:login/login.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../api_company/repository/api_company_repository.dart';
import '../api_knowledge/api_knowledge_service.dart';
import 'model/api_company_model.dart';

class ApiCompanyService {
  final _log = Logger('ApiCompanyService');
  final ApiCompanyRepository _repositoryLocal;
  final ApiKnowledgeService _apiKnowledgeService;
  final Login _login;

  ApiCompanyService(
      {required Database database,
      required ApiKnowledgeService apiKnowledgeService,
      required Login login})
      : this._repositoryLocal = ApiCompanyRepository(database),
        this._apiKnowledgeService = apiKnowledgeService,
        this._login = login;

  Future<void> upsert(String domain,
      {Function(ApiCompanyModel?)? onComplete}) async {
    if (domain.isNotEmpty) {
      ApiCompanyModel? local = await _repositoryLocal.getByDomain(domain);
      if (local == null) {
        await _apiKnowledgeService.getCompany(
            accessToken: _login.token!.bearer!,
            domain: domain,
            onSuccess: (company) async {
              ApiCompanyModel saved =
                  await _repositoryLocal.insert(ApiCompanyModel(
                domain: domain,
                logo: company.about?.logo,
                securityScore: company.score?.securityScore,
                breachScore: company.score?.breachScore,
                sensitivityScore: company.score?.sensitivityScore,
              ));
              if (onComplete != null) onComplete(saved);
            },
            onError: (error) => _log.warning(error));
      } else if (local.modified == null ||
          local.securityScore == null ||
          local.modified!
              .isBefore(DateTime.now().subtract(Duration(days: 30)))) {
        await _apiKnowledgeService.getCompany(
            accessToken: _login.token!.bearer!,
            domain: domain,
            onSuccess: (company) async {
              ApiCompanyModel saved = await _repositoryLocal.update(
                  ApiCompanyModel(
                      companyId: local.companyId,
                      domain: domain,
                      logo: company.about?.logo,
                      securityScore: company.score?.securityScore,
                      breachScore: company.score?.breachScore,
                      sensitivityScore: company.score?.sensitivityScore,
                      created: local.created,
                      modified: local.modified));
              if (onComplete != null) onComplete(saved);
            },
            onError: (error) => _log.warning(error));
      } else if (onComplete != null) onComplete(local);
    }
  }

  Future<ApiCompanyModel?> getById(int? companyId) async {
    if (companyId == null) return null;
    var company = await _repositoryLocal.getById(companyId);
    return company;
  }

  static String? domainFromEmail(String? email) {
    if (email != null) {
      List<String> atSplit = email.split('@');
      List<String> periodSplit = atSplit[atSplit.length - 1].split('.');
      return periodSplit[periodSplit.length - 2] +
          "." +
          periodSplit[periodSplit.length - 1];
    }
    return null;
  }
}
