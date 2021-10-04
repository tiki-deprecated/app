/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter/services.dart';

class ApiMicrosoftRepositoryInfo {
  // TODO Microsoft cards
  static const _dbLocationOutlook = "res/json/microsoft_info_gmail_db.json";

  Future<List<dynamic>> outlook() => _load(_dbLocationOutlook);

  Future<List<dynamic>> _load(String location) async {
    String jsonString = await rootBundle.loadString(location);
    return jsonDecode(jsonString);
  }
}
