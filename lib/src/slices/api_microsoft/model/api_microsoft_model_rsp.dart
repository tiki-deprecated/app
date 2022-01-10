/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import '../../../utils/json/json_utils.dart';

class ApiMicrosoftModelRsp<T extends JsonObject> extends JsonObject {
  String? context;
  String? nextLink;
  dynamic value;

  ApiMicrosoftModelRsp({this.context, this.nextLink, required this.value});

  ApiMicrosoftModelRsp.fromJson(
      Map<String, dynamic>? json, T fromJson(Map<String, dynamic>? json)) {
    if (json != null) {
      context = json['@odata.context'];
      nextLink = json['@odata.nextLink'];
      if (json['value'] != null) {
        value = json['value'] is List
            ? JsonUtils.listFromJson(json['value'], fromJson)
            : fromJson(json);
      }
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        '@odata.context': context,
        '@odata.nextLink': nextLink,
        'value': value?.toJson()
      };
}
