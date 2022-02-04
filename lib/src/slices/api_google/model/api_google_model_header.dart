/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiGoogleModelHeader extends JsonObject {
  String? name;
  String? value;

  ApiGoogleModelHeader({this.name, this.value});

  ApiGoogleModelHeader.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      name = json['name'];
      value = json['value'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}
