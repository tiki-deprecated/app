/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class UIMagicLinkModel {
  String email;
  bool isError = false;
  bool isReady = false;

  UIMagicLinkModel({this.email, this.isError = false, this.isReady = false});
}
