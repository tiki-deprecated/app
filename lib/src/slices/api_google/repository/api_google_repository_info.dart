/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter/services.dart';

class ApiGoogleRepositoryInfo {
  static const _dbLocationGmail = "res/json/google_info_gmail_db.json";

  Future<List<dynamic>> gmail() => _load(_dbLocationGmail);

  Future<List<dynamic>> _load(String location) async {
    String jsonString = await rootBundle.loadString(location);
    return jsonDecode(jsonString);
  }
}
