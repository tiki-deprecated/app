/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'keys_modal_service.dart';

class KeysModalController {
  final KeysModalService service;

  KeysModalController(this.service);

  void createNewKeys() {}

  void goToKeyScan() {}

  void scanQrCode() {}

  void enterPinCode() {}

  submitPincode(String text) {}

  submitPassphrase(String text) {}

  passphraseChanged(String text) {}
}
