/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class MagicLinkModel {
  String email;
  bool isError = false;
  bool isReady = false;

  MagicLinkModel({this.email, this.isError = false, this.isReady = false});
}
