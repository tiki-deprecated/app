/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'package:login/login.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../slices/api_short_code/api_short_code_model_claim.dart';
import '../slices/api_short_code/api_short_code_service.dart';
import 'database.dart' as db;

const String _prefix = 'com.mytiki.app';
const String _versionPrefix = '0.0.1';
const String _currentPrefix =
    _prefix + '.' + 'current' + '.' + _versionPrefix + '.user';
const String _userPrefix = _prefix + '.' + 'user' + '.' + _versionPrefix + '.';
const String _keysPrefix = _prefix + '.' + 'keys' + '.' + _versionPrefix + '.';

Future<void> upgrade(Login login, Httpp httpp) async {
  Logger log = Logger('upgrade');
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? email = await getEmail(secureStorage);
  if (email != null) {
    String? address = await getAddress(secureStorage, email);
    if (address != null) {
      String? pw = await getPw(secureStorage, address);
      if (pw != null) {
        Database database = await db.open(pw, dbName: 'tiki_enc.db');
        String? code = await getCode(database);
        if (code != null) {
          ApiShortCodeService shortCodeService =
              ApiShortCodeService(httpp: httpp, refresh: login.refresh);
          await shortCodeService.claim(
              accessToken: login.token!.bearer!,
              claim: ApiShortCodeModelClaim(
                  code: code, address: login.user!.address!),
              onSuccess: (rsp) async {
                await secureStorage.delete(key: _currentPrefix);
                await secureStorage.delete(key: _userPrefix + email);
                await secureStorage.delete(key: _keysPrefix + address);
              },
              onError: (error) => log.warning(error));
        }
      }
    }
  }
}

Future<String?> getEmail(FlutterSecureStorage secureStorage) async {
  String? currentJson = await secureStorage.read(key: _currentPrefix);
  if (currentJson != null) {
    Map<String, dynamic> currentMap = jsonDecode(currentJson);
    return currentMap['email'];
  }
}

Future<String?> getAddress(
    FlutterSecureStorage secureStorage, String email) async {
  String? userJson = await secureStorage.read(key: _userPrefix + email);
  if (userJson != null) {
    Map<String, dynamic> userMap = jsonDecode(userJson);
    return userMap['address'];
  }
}

Future<String?> getPw(
    FlutterSecureStorage secureStorage, String address) async {
  String? keysJson = await secureStorage.read(key: _keysPrefix + address);
  if (keysJson != null) {
    Map<String, dynamic> keysMap = jsonDecode(keysJson);
    return keysMap['signPrivateKey'];
  }
}

Future<String?> getCode(Database database) async {
  List<Map<String, Object?>> rows = await database
      .query('app_data', where: "key = ?", whereArgs: ['user_refer_code']);
  if (rows.isNotEmpty) return rows[0]['value'] as String;
}
