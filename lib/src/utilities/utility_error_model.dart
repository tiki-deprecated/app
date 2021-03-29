/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class StreamErrorModel {
  bool isError = true;
  String message;
  dynamic error;

  StreamErrorModel(this.message, {this.isError = true, this.error});
}
