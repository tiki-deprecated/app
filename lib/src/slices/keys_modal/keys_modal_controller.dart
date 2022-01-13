/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:wallet/wallet.dart';

import 'keys_modal_service.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/helper_permission.dart';

class KeysModalController {
  final KeysModalService service;

  KeysModalController(this.service);

  void createNewKeys() {
    this.service.startKeysCreation();
  }

  Future<void> scanQrCode() async {
    if (await HelperPermission.request(Permission.camera)) {
      ScanResult result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        service.provideKeys(TikiKeysModel.fromCombinedString(result.rawContent));
      }
    }
  }

  void enterPinCode() {
    this.service.startPincode();
  }

  submitPincode(int pin) {
    if(this.service.verifyPincode(pin)){
      this.service.startPassphraseWithPin(pin);
    }else{
      this.service.pincodeError();
    }
  }

  submitPassphrase(String pass) {
    if(this.service.verifyPassphrase(pass)){
      this.service.createKeysAndSaveWithPass(pass);
    }else{
      this.service.passphraseError();
    }
  }

  passphraseChanged(String text) {}

  void goToKeysScan() {
    this.service.goToKeysScanQuestion();
  }
}
