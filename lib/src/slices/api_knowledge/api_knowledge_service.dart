/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';

import '../../utils/api/tiki_api_model_rsp.dart';
import 'model/company/api_knowledge_model_company.dart';
import 'model/edge/api_knowledge_model_edge.dart';
import 'repository/api_knowledge_repository_company.dart';
import 'repository/api_knowledge_repository_edge.dart';

class ApiKnowledgeService {
  final HttppClient _client;
  final Future<void> Function(void Function(String?)? onSuccess)? refresh;
  final ApiKnowledgeRepositoryEdge _repositoryEdge;
  final ApiKnowledgeRepositoryCompany _repositoryCompany;

  ApiKnowledgeService({Httpp? httpp, this.refresh})
      : _client = httpp?.client() ?? Httpp().client(),
        _repositoryEdge = ApiKnowledgeRepositoryEdge(),
        _repositoryCompany = ApiKnowledgeRepositoryCompany();

  Future<void> getCompany(
          {required String accessToken,
          required String domain,
          Function(Object)? onError,
          Function(ApiKnowledgeModelCompany)? onSuccess}) async =>
      _auth(
          accessToken,
          onError,
          (token, onError) => _repositoryCompany.get(
              client: _client,
              accessToken: token,
              domain: domain,
              onSuccess: (rsp) {
                if (onSuccess != null) {
                  onSuccess(rsp.data as ApiKnowledgeModelCompany);
                }
              },
              onError: onError));

  Future<void> addEdges(
          {required String accessToken,
          required List<ApiKnowledgeModelEdge> edges,
          Function(Object)? onError,
          Function(TikiApiModelRsp)? onSuccess}) async =>
      _auth(
          accessToken,
          onError,
          (token, onError) => _repositoryEdge.post(
              client: _client,
              accessToken: token,
              body: edges,
              onSuccess: onSuccess,
              onError: onError));

  Future<T> _auth<T>(String accessToken, Function(Object)? onError,
      Future<T> Function(String, Future<void> Function(Object)) request) async {
    return request(accessToken, (error) async {
      if (error is TikiApiModelRsp && error.code == 401 && refresh != null) {
        await refresh!((token) async {
          if (token != null) {
            await request(
                token,
                (error) async =>
                    onError != null ? onError(error) : throw error);
          }
        });
      } else {
        onError != null ? onError(error) : throw error;
      }
    });
  }
}
