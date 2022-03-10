/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../../utils/json/json_object.dart';

class ApiKnowledgeModelFingerprintReq extends JsonObject {
  Set<String>? fingerprints;

  ApiKnowledgeModelFingerprintReq({this.fingerprints});

  ApiKnowledgeModelFingerprintReq.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      fingerprints =
          json['fingerprints'] != null ? Set.from(json['fingerprints']) : null;
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'fingerprints': fingerprints,
      };
}
