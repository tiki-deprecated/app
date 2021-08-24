import 'dart:convert';

import 'package:flutter/services.dart';

class ApiAuthServiceRepository {
  static const _dbAuthProviders = "res/json/auth_providers_db.json";

  Future<List<dynamic>> providersData() => _load(_dbAuthProviders);

  Future<List<dynamic>> _load(String location) async {
    String jsonString = await rootBundle.loadString(location);
    return jsonDecode(jsonString);
  }
}
