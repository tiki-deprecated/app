/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class HelperJson {
  static List listToJson(List? list) {
    return list!.map((e) => e!.toJson()).toList();
  }

  static List<T> listFromJson<T>(
      List<dynamic>? json, Function(Map<String, dynamic>?) fromJson) {
    List<T> res = [];
    json!.forEach((element) => res.add(fromJson(element)));
    return res;
  }
}
