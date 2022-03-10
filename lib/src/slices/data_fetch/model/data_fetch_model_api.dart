/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class DataFetchModelApi {
  final String _value;

  const DataFetchModelApi._(this._value);

  static const gmail = DataFetchModelApi._('gmail');
  static const outlook = DataFetchModelApi._('outlook');

  static const values = [gmail, outlook];

  String get value => _value;

  static DataFetchModelApi? from(String s) {
    for (DataFetchModelApi api in values) {
      if (api.value == s) return api;
    }
    return null;
  }

  @override
  String toString() {
    return 'DataFetchModelApi.$_value';
  }
}
