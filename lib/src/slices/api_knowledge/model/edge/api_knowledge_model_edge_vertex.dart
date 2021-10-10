/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiKnowledgeModelEdgeVertex {
  String? type;
  String? value;

  ApiKnowledgeModelEdgeVertex({this.type, this.value});

  ApiKnowledgeModelEdgeVertex.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.type = json['type'];
      this.value = json['value'];
    }
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
      };
}
