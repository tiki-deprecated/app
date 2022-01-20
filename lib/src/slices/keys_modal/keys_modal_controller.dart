/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'model/keys_modal_steps.dart';
import 'package:wallet/wallet.dart';

import 'keys_modal_service.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/helper_permission.dart';

class KeysModalController {
  final KeysModalService service;

  KeysModalController(this.service);

  void createNewKeys() {
    this.service.enterNewPinCode();
  }

  Future<void> scanQrCode() async {
    if (await HelperPermission.request(Permission.camera)) {
      ScanResult result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        List keys = result.rawContent.split(".");
        service.provideKeys(TikiKeysModel.decode(keys[0], keys[2], keys[1]));
      }
    }
  }

  void submitPincode(String pin) {
    if(this.service.checkPinCode(pin)){
      if(this.service.model.step == KeysModalSteps.enterNewPinCode){
        this.service.model.newPincode = pin;
        this.service.enterNewPassphrase();
      }else if(this.service.model.step == KeysModalSteps.enterBkpPinCode){
        this.service.model.bkpPincode = pin;
        this.service.enterBkpPassphrase();
      }
    }else{
      this.service.pincodeError();
    }
  }

  void submitPassphrase(String pass) {
    if(this.service.checkPassphrase(pass)){
      if(this.service.model.step == KeysModalSteps.enterNewPassPhrase){
        this.service.model.newPassphrase = pass;
        if(this.service.model.bkpPassphrase != null) {
          this.service.cycleKeysInBkpService();
        }else{
          this.service.createKeysAndSave();
        }
      }else if(this.service.model.step == KeysModalSteps.enterBkpPassPhrase){
        this.service.model.bkpPassphrase = pass;
        this.service.recoverKeys();
      }
    }else{
      this.service.pincodeError();
    }
  }

  void passphraseChanged(String text) {}

  void goToKeysScan() {
    this.service.goToKeysScanQuestion();
  }

  void restoreKeys() {
    this.service.enterBkpPincode();
  }
}
