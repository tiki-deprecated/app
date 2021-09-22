/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/api_oauth_model_provider.dart';

/// This db should be defined at res/json/auth_providers_db.json in the
/// following format:
///     "provider_name" : {
///         "clientId" : the client identifier for the provider
///         "authorizationEndpoint" : auth url
///         "tokenEndpoint" : token url
///         "redirectUrl" : redirect url (default [ApiAuthServiceModel.redirectUrl])
///         "discoveryUrl" : discovery url
///     }
///
class ApiOAuthRepositoryProvider {
  static const _dbAuthProviders = "res/json/auth_providers_db.json";
  Map? providers;

  ApiOAuthRepositoryProvider() {
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    String jsonString = await rootBundle.loadString(_dbAuthProviders);
    this.providers = jsonDecode(jsonString);
  }

  static Future<Map<String, dynamic>> getProviders() async {
    String jsonString = await rootBundle.loadString(_dbAuthProviders);
    return jsonDecode(jsonString);
  }

  Future<ApiOAuthModelProvider?> getProvider(String providerName) async {
    if (providers == null) {
      await _loadProviders();
    }
    ApiOAuthModelProvider? providerModel =
        ApiOAuthModelProvider.fromMap(providers?[providerName]);
    return providerModel;
  }
}
