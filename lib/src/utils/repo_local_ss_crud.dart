/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class RepoLocalSsCrud<T> {
  static const _keyPrefix = 'com.mytiki.app';
  final String _table;
  final String _version;
  final FlutterSecureStorage secureStorage;
  final Map<String, dynamic> Function(T model) _toJson;
  final T Function(Map<String, dynamic>? json) _fromJson;

  RepoLocalSsCrud(this._table, this._version, this._toJson, this._fromJson,
      {FlutterSecureStorage? secureStorage})
      : secureStorage =
            (secureStorage == null ? FlutterSecureStorage() : secureStorage);

  Future<void> save(String key, T model) async {
    await secureStorage.write(
        key: _longKey(key), value: jsonEncode(_toJson(model)));
  }

  Future<T> find(String key) async {
    String? raw = await secureStorage.read(key: _longKey(key));
    Map? jsonMap;
    if (raw != null) jsonMap = jsonDecode(raw);
    return _fromJson(jsonMap as Map<String, dynamic>?);
  }

  Future<void> delete(String key) async {
    await secureStorage.delete(key: _longKey(key));
  }

  String _longKey(String key) {
    return _keyPrefix + "." + _table + "." + _version + "." + key;
  }
}
