import 'dart:convert';

import 'package:flutter/services.dart';

class ApiAuthServiceRepository {
  static const _dbAuthProviders = "res/json/auth_providers_db.json";
  late Map providers;

  ApiAuthServiceRepository() {
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    String jsonString = await rootBundle.loadString(_dbAuthProviders);
    this.providers = jsonDecode(jsonString);
  }
}
