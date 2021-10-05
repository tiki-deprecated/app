/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiKnowledgeModelFingerprintRspEdge {
  Set<String>? fingerprints;
  Map<String, Object>? from;
  Map<String, Object>? to;

  ApiKnowledgeModelFingerprintRspEdge({this.fingerprints, this.from, this.to});

  ApiKnowledgeModelFingerprintRspEdge.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.fingerprints =
          json['fingerprints'] != null ? Set.from(json['fingerprints']) : null;
      this.from = json['from'] != null ? Map.from(json['from']) : null;
      this.to = json['to'] != null ? Map.from(json['to']) : null;
    }
  }

  Map<String, dynamic> toJson() => {
        'fingerprints': fingerprints,
        'to': to,
        'from': from,
      };
}
