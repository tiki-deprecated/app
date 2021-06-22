/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/app/model/app_model_current.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_current.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_user.dart';
import 'package:app/src/slices/keys_screen/model/keys_screen_model.dart';
import 'package:app/src/slices/keys_screen/secure_storage_repository_keys.dart';
import 'package:app/src/slices/login_screen/model/login_screen_model_token.dart';
import 'package:app/src/slices/login_screen/secure_storage_repository_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  late SecureStorageRepositoryCurrent _secureStorageRepositoryCurrent;
  late SecureStorageRepositoryUser _repoLocalSsUser;
  late SecureStorageRepositoryKeys _repoLocalSsKeys;
  late SecureStorageRepositoryToken _repoLocalSsToken;
  late FlutterSecureStorage secureStorage;

  late AppModelCurrent current;

  AppModelUser? user;
  KeysScreenModel? keys;
  LoginScreenModelToken? token;

  AuthService() : secureStorage = FlutterSecureStorage() {
    _secureStorageRepositoryCurrent = SecureStorageRepositoryCurrent(secureStorage: secureStorage);
    _repoLocalSsUser = SecureStorageRepositoryUser(secureStorage: secureStorage);
    _repoLocalSsKeys = SecureStorageRepositoryKeys(secureStorage: secureStorage);
    _repoLocalSsToken = SecureStorageRepositoryToken(secureStorage: secureStorage);
  }

  Future<AuthService> load() async {
    current = await _secureStorageRepositoryCurrent.find(SecureStorageRepositoryCurrent.key);
    if (current.email != null) {
      user = await _repoLocalSsUser.find(current.email!);
      if (user!.address != null)
        keys = await _repoLocalSsKeys.find(user!.address!);
      token = await _repoLocalSsToken.find(current.email!);
    }
    return this;
  }

  bool isReturning() {
    return current.email != null;
  }

  bool isLoggedIn() {
    return user != null &&
        user!.isLoggedIn != null &&
        user!.isLoggedIn! &&
        keys != null &&
        keys!.address != null &&
        keys!.signPrivateKey != null &&
        keys!.dataPrivateKey != null &&
        token != null &&
        token!.refresh != null;
  }

  void logout(){

  }

  void login(){

  }
}
