/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../../utils/json/json_object.dart';
import 'api_knowledge_model_vertex_field.dart';

class ApiKnowledgeModelVertex extends JsonObject {
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

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'fields': fields?.map((f) => f.toJson()).toList(),
      };
}
