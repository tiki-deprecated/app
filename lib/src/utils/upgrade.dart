/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login/login.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'database.dart' as db;

const String _prefix = 'com.mytiki.app';
const String _versionPrefix = '0.0.1';

Future<void> upgrade(Login login) async {
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? address = await getAddress(secureStorage);
  if (address != null) {
    String? pw = await getPw(secureStorage, address);
    if (pw != null) {
      Database database = await db.open(pw, dbName: 'tiki_enc.db');
      String? code = await getCode(database);
      print('old address is: ' + address);
      print('new address is: ' + (login.user?.address ?? ''));
      print('code is: ' + (code ?? ''));
    }
  }
}

Future<String?> getAddress(FlutterSecureStorage secureStorage) async {
  String currentPrefix = _prefix + '.' + 'current' + '.' + _versionPrefix + '.';
  String userPrefix = _prefix + '.' + 'user' + '.' + _versionPrefix + '.';
  String? currentJson = await secureStorage.read(key: currentPrefix + 'user');
  if (currentJson != null) {
    Map<String, dynamic> currentMap = jsonDecode(currentJson);
    String? userJson =
        await secureStorage.read(key: userPrefix + currentMap['email']);
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return userMap['address'];
    }
  }
}

Future<String?> getPw(
    FlutterSecureStorage secureStorage, String address) async {
  String keysPrefix = _prefix + '.' + 'keys' + '.' + _versionPrefix + '.';
  String? keysJson = await secureStorage.read(key: keysPrefix + address);
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
