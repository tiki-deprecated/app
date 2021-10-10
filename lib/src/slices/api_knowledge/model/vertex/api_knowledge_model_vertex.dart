/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'api_knowledge_model_vertex_field.dart';

class ApiKnowledgeModelVertex {
  String? type;
  List<ApiKnowledgeModelVertexField>? fields;

  ApiKnowledgeModelVertex({this.type, this.fields});

  ApiKnowledgeModelVertex.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.type = json['type'];
      List? fields = json['fields'];
      this.fields = fields != null
          ? fields.map((f) => ApiKnowledgeModelVertexField.fromJson(f)).toList()
          : null;
    }
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'fields': fields?.map((f) => f.toJson()).toList(),
      };
}
