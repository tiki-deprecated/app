/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../../utils/json/json_object.dart';

class ApiKnowledgeModelVertexField extends JsonObject {
  String? name;
  String? dataType;

  ApiKnowledgeModelVertexField({this.name, this.dataType});

  ApiKnowledgeModelVertexField.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.name = json['name'];
      this.dataType = json['dataType'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'dataType': dataType,
      };
}
