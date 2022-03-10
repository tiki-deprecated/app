/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../../utils/json/json_object.dart';

class ApiKnowledgeModelFingerprintRspEdge extends JsonObject {
  Set<String>? fingerprints;
  Map<String, Object>? from;
  Map<String, Object>? to;

  ApiKnowledgeModelFingerprintRspEdge({this.fingerprints, this.from, this.to});

  ApiKnowledgeModelFingerprintRspEdge.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      fingerprints =
          json['fingerprints'] != null ? Set.from(json['fingerprints']) : null;
      from = json['from'] != null ? Map.from(json['from']) : null;
      to = json['to'] != null ? Map.from(json['to']) : null;
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'fingerprints': fingerprints,
        'to': to,
        'from': from,
      };
}
