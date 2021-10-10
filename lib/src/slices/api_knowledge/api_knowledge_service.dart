/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../utils/api/helper_api_auth.dart';
import '../../utils/api/helper_api_rsp.dart';
import 'model/company/api_knowledge_model_company.dart';
import 'model/edge/api_knowledge_model_edge.dart';
import 'repository/api_knowledge_repository_company.dart';
import 'repository/api_knowledge_repository_edge.dart';

class ApiKnowledgeService {
  final HelperApiAuth helperApiAuth;

  ApiKnowledgeService(this.helperApiAuth);

  Future<HelperApiRsp<ApiKnowledgeModelCompany>> getCompany(
          String domain) async =>
      await helperApiAuth.proxy(() =>
          ApiKnowledgeRepositoryCompany.get(helperApiAuth.bearer, domain));

  Future<HelperApiRsp> addEdges(List<ApiKnowledgeModelEdge> edges) async =>
      await helperApiAuth.proxy(
          () => ApiKnowledgeRepositoryEdge.post(helperApiAuth.bearer, edges));
}
