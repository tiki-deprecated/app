/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiKnowledgeModelFingerprintReq {
  Set<String>? fingerprints;

  ApiKnowledgeModelFingerprintReq({this.fingerprints});

  ApiKnowledgeModelFingerprintReq.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.fingerprints =
          json['fingerprints'] != null ? Set.from(json['fingerprints']) : null;
    }
  }

  Map<String, dynamic> toJson() => {
        'fingerprints': fingerprints,
      };
}
