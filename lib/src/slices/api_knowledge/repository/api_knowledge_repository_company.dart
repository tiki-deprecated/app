/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../../../utils/api/tiki_api_model_rsp.dart';
import '../model/company/api_knowledge_model_company.dart';

class ApiKnowledgeRepositoryCompany {
  final Logger _log = Logger('ApiKnowledgeRepositoryCompany');
  static final String _path = '/api/latest/vertex/company';

  Future<void> get(
      {required HttppClient client,
      String? accessToken,
      required String domain,
      void Function(TikiApiModelRsp<ApiKnowledgeModelCompany>)? onSuccess,
      void Function(Object)? onError}) {
    HttppRequest request = HttppRequest(
        uri: Uri.https('knowledge.mytiki.com', _path, {'domain': domain}),
        verb: HttppVerb.GET,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: Duration(seconds: 30),
        onSuccess: (rsp) {
          if (onSuccess != null) {
            TikiApiModelRsp<ApiKnowledgeModelCompany> body =
                TikiApiModelRsp.fromJson(rsp.body?.jsonBody,
                    (json) => ApiKnowledgeModelCompany.fromJson(json));
            onSuccess(body);
          }
        },
        onResult: (rsp) {
          TikiApiModelRsp body =
              TikiApiModelRsp.fromJson(rsp.body?.jsonBody, (json) {});
          if (onError != null) onError(body);
        },
        onError: onError);
    _log.finest('${request.verb.value} — ${request.uri}');
    return client.request(request);
  }
}
