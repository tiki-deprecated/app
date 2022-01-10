/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiMicrosoftModelHeader extends JsonObject {
  String? value;
  String? name;

  ApiMicrosoftModelHeader.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      value = json['value'];
      name = json['name'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'value': value, 'name': name};
}
