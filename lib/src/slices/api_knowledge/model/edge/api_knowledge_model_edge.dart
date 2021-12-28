/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../../utils/json/json_object.dart';
import 'api_knowledge_model_edge_vertex.dart';

class ApiKnowledgeModelEdge extends JsonObject {
  ApiKnowledgeModelEdgeVertex? to;
  ApiKnowledgeModelEdgeVertex? from;
  String? fingerprint;

  ApiKnowledgeModelEdge({this.to, this.from, this.fingerprint});

  ApiKnowledgeModelEdge.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.to = ApiKnowledgeModelEdgeVertex.fromJson(json['to']);
      this.from = ApiKnowledgeModelEdgeVertex.fromJson(json['from']);
      this.fingerprint = json['fingerprint'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'to': to?.toJson(),
        'from': from?.toJson(),
        'fingerprint': fingerprint,
      };
}
