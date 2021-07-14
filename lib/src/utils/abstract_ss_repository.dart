/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AbstractSsRepository<T> {
  static const _keyPrefix = 'com.mytiki.app';
  final String table;
  final String version;
  final FlutterSecureStorage secureStorage;
  final Map<String, dynamic> Function(T model) toJson;
  final T Function(Map<String, dynamic>? json) fromJson;

  AbstractSsRepository(
      {required this.table,
      required this.version,
      required this.toJson,
      required this.fromJson,
      required this.secureStorage});

  Future<void> save(String key, T model) async {
    await secureStorage.write(
        key: _longKey(key), value: jsonEncode(toJson(model)));
  }

  Future<T> find(String key) async {
    String? raw = await secureStorage.read(key: _longKey(key));
    Map? jsonMap;
    if (raw != null) jsonMap = jsonDecode(raw);
    return fromJson(jsonMap as Map<String, dynamic>?);
  }

  Future<void> delete(String key) async {
    await secureStorage.delete(key: _longKey(key));
  }

  String _longKey(String key) {
    return _keyPrefix + "." + table + "." + version + "." + key;
  }
}
