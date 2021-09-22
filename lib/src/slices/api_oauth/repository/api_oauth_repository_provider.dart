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
  late final Map<String, ApiOAuthModelProvider> _providers;

  ApiOAuthRepositoryProvider() {
    _loadProviders();
  }

  Map<String, ApiOAuthModelProvider> get providers => _providers;

  Future<void> _loadProviders() async {
    String jsonString = await rootBundle.loadString(_dbAuthProviders);
    Map<String, Map<String, dynamic>> jsonMap = jsonDecode(jsonString);
    _providers = jsonMap.map(
        (key, value) => MapEntry(key, ApiOAuthModelProvider.fromMap(value)));
  }
}
