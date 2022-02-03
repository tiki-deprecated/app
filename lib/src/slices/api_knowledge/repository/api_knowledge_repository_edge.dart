/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../../../utils/api/tiki_api_model_rsp.dart';
import '../../../utils/json/json_utils.dart';
import '../model/edge/api_knowledge_model_edge.dart';

class ApiKnowledgeRepositoryEdge {
  final Logger _log = Logger('ApiKnowledgeRepositoryEdge');
  static final String _path = 'https://knowledge.mytiki.com/api/latest/edge';

  Future<void> post(
      {required HttppClient client,
      String? accessToken,
      List<ApiKnowledgeModelEdge>? body,
      void Function(TikiApiModelRsp)? onSuccess,
      void Function(Object)? onError}) {
    HttppRequest request = HttppRequest(
        uri: Uri.parse(_path),
        verb: HttppVerb.POST,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        body: HttppBody(jsonEncode(JsonUtils.listToJson(body))),
        timeout: Duration(seconds: 30),
        onSuccess: (rsp) {
          if (onSuccess != null) {
            TikiApiModelRsp body =
                TikiApiModelRsp.fromJson(rsp.body?.jsonBody, (json) {});
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
