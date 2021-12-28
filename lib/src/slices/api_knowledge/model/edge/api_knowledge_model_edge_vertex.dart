/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../../utils/json/json_object.dart';

class ApiKnowledgeModelEdgeVertex extends JsonObject {
  String? type;
  String? value;

  ApiKnowledgeModelEdgeVertex({this.type, this.value});

  ApiKnowledgeModelEdgeVertex.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.type = json['type'];
      this.value = json['value'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
      };
}
