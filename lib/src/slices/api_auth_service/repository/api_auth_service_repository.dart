import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/api_auth_service_provider_model.dart';

class ApiAuthServiceRepository {
  static const _dbAuthProviders = "res/json/auth_providers_db.json";
  Map? providers;

  ApiAuthServiceRepository() {
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    String jsonString = await rootBundle.loadString(_dbAuthProviders);
    this.providers = jsonDecode(jsonString);
  }

  Future<ApiAuthServiceProviderModel?> getProvider(String providerName) async {
    if (providers == null) {
      await _loadProviders();
    }
    ApiAuthServiceProviderModel? providerModel =
        ApiAuthServiceProviderModel.fromMap(providers?[providerName]);
    return providerModel;
  }
}
