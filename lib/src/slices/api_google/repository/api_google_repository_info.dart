/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter/services.dart';

class ApiGoogleRepositoryInfo {
  static const _dbLocation = "res/json/google_info_db.json";

  Future<List<dynamic>> load() async {
    String jsonString = await rootBundle.loadString(_dbLocation);
    return jsonDecode(jsonString);
  }
}
