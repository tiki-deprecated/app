/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiKnowledgeModelVertexField {
  String? name;
  String? dataType;

  ApiKnowledgeModelVertexField({this.name, this.dataType});

  ApiKnowledgeModelVertexField.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.name = json['name'];
      this.dataType = json['dataType'];
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'dataType': dataType,
      };
}
