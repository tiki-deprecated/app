/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class DataFetchModelPage<T> {
  List<T>? data;
  dynamic next;

  DataFetchModelPage({this.data, this.next});
}
