/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/repositories/security_keys/security_keys_model.dart';
import 'package:app/src/repositories/security_keys/security_keys_model_keypair.dart';
import 'package:app/src/repositories/security_keys/security_keys_store.dart';
import 'package:app/src/repositories/security_keys/security_keys_store_users.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class SecurityKeysBloc {
  static final String usersKey = "com.mytiki.app.users";
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  SecurityKeysModel securityKeysModel;
  BehaviorSubject<SecurityKeysModel> _subjectModel;

  SecurityKeysBloc() {
    securityKeysModel = SecurityKeysModel();
    _subjectModel = BehaviorSubject.seeded(securityKeysModel);
  }

  Observable<SecurityKeysModel> get observableModel => _subjectModel.stream;

  Future<void> write(String email, SecurityKeysModel model,
      {bool overwrite}) async {
    String storeUuid = await _getOrCreateUserKey(email);
    if (!(await _secureStorage.containsKey(key: usersKey + storeUuid)) ||
        overwrite) {
      SecurityKeysStore store = SecurityKeysStore(
          email: email,
          id: model.id,
          dataPublicKey: model.dataKeys?.encodedPublicKey,
          dataPrivateKey: model.dataKeys?.encodedPrivateKey,
          signPublicKey: model.signKeys?.encodedPublicKey,
          signPrivateKey: model.signKeys?.encodedPublicKey);
      await _secureStorage.write(
          key: usersKey + storeUuid, value: jsonEncode(store.toJson()));
      _subjectModel.sink.add(model);
    }
  }

  Future<SecurityKeysModel> read(String email) async {
    String storeUuid = await _getUserKey(email);
    SecurityKeysModel model = SecurityKeysModel();
    model.signKeys = SecurityKeysNewModelKeyPair<ECPublicKey, ECPrivateKey>();
    model.dataKeys = SecurityKeysNewModelKeyPair<RSAPublicKey, RSAPrivateKey>();
    if (storeUuid != null &&
        await _secureStorage.containsKey(key: usersKey + storeUuid)) {
      Map keyStoreMap =
          jsonDecode(await _secureStorage.read(key: usersKey + storeUuid));
      SecurityKeysStore keysStore = SecurityKeysStore.fromJson(keyStoreMap);
      model.email = keysStore.email;
      model.id = keysStore.id;
      model.signKeys.encodedPublicKey = keysStore.signPublicKey;
      model.signKeys.encodedPrivateKey = keysStore.signPrivateKey;
      model.dataKeys.encodedPublicKey = keysStore.dataPublicKey;
      model.dataKeys.encodedPrivateKey = keysStore.dataPrivateKey;
    }
    _subjectModel.sink.add(model);
    return model;
  }

  Future<String> _getOrCreateUserKey(String email) async {
    SecurityKeysStoreUsers storeUsers = SecurityKeysStoreUsers(users: Map());
    if (!await _secureStorage.containsKey(key: usersKey)) {
      storeUsers.users[email] = Uuid().v4();
      await _secureStorage.write(
          key: usersKey, value: jsonEncode(storeUsers.toJson()));
    } else {
      Map storeUsersMap = jsonDecode(await _secureStorage.read(key: usersKey));
      storeUsers = SecurityKeysStoreUsers.fromJson(storeUsersMap);
      if (!storeUsers.users.containsKey(email)) {
        storeUsers.users[email] = Uuid().v4();
        await _secureStorage.write(
            key: usersKey, value: jsonEncode(storeUsers.toJson()));
      }
    }
    return storeUsers.users[email];
  }

  Future<String> _getUserKey(String email) async {
    SecurityKeysStoreUsers storeUsers;
    if (!await _secureStorage.containsKey(key: usersKey))
      return null;
    else
      return jsonDecode(await _secureStorage.read(key: usersKey))[email];
  }

  void dispose() {
    _subjectModel.close();
  }
}
