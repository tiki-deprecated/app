/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'json_object.dart';

class JsonUtils {
  static List<Map<String, dynamic>>? listToJson(List<JsonObject>? list) {
    return list?.map((e) => e.toJson()).toList();
  }

  static List<T>? listFromJson<T>(
      List<dynamic>? json, Function(Map<String, dynamic>?) fromJson) {
    if (json != null) {
      List<T> res = [];
      for (var element in json) {
        res.add(fromJson(element));
      }
      return res;
    }
    return null;
  }
}
