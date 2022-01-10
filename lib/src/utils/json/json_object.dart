/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

abstract class JsonObject {
  /// classes that extend JsonObject should implement a fromJson
  /// factory constructor. For example:
  /// ClassX.fromJson(Map<String, dynamic>? json){}

  Map<String, dynamic> toJson();
}
