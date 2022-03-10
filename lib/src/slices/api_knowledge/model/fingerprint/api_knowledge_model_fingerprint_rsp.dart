/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../../utils/json/json_object.dart';
import 'api_knowledge_model_fingerprint_rsp_edge.dart';

class ApiKnowledgeModelFingerprintRsp extends JsonObject {
  Set<String>? fingerprints;
  ApiKnowledgeModelFingerprintRspEdge? from;
  ApiKnowledgeModelFingerprintRspEdge? to;

  ApiKnowledgeModelFingerprintRsp({this.fingerprints, this.from, this.to});

  ApiKnowledgeModelFingerprintRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      fingerprints =
          json['fingerprints'] != null ? Set.from(json['fingerprints']) : null;
      from = ApiKnowledgeModelFingerprintRspEdge.fromJson(json['from']);
      from = ApiKnowledgeModelFingerprintRspEdge.fromJson(json['to']);
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'fingerprints': fingerprints,
        'from': from?.toJson(),
        'to': to?.toJson(),
      };
}
