/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_modal/model/keys_modal_error.dart';
import 'package:flutter/material.dart';

import 'model/keys_modal_steps.dart';
import 'package:wallet/wallet.dart';

import 'keys_modal_service.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/helper_permission.dart';

class KeysModalController {
  final KeysModalService service;

  KeysModalController(this.service);

  void goToCreateNewKeys() {
    this.service.enterNewPinCode();
  }

  Future<void> scanQrCode() async {
    if (await HelperPermission.request(Permission.camera)) {
      ScanResult result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        List keys = result.rawContent.split(".");
        try {
          service.provideKeys(TikiKeysModel.decode(keys[0], keys[2], keys[1]));
        }catch(e){
          print(e);
          this.service.setError(KeysModalError.invalidQrCode);
        }
      }
    }
  }

  void submitPincode(String pin) {
    if(pin.length == 6){
      if(this.service.model.step == KeysModalSteps.enterNewPinCode){
        this.service.model.newPincode = pin;
        this.service.enterNewPassphrase();
      }else if(this.service.model.step == KeysModalSteps.enterBkpPinCode){
        this.service.model.bkpPincode = pin;
        if(this.service.model.bkpPincode == this.service.model.newPincode){
          this.service.setError(KeysModalError.repeatedPinCode);
        }else {
          this.service.enterBkpPassphrase();
        }
      }
    }else{
      this.service.setError(KeysModalError.pincodeLength);
    }
  }

  void submitPassphrase(String pass) {
    if(pass.length >= 8){
      if(this.service.model.step == KeysModalSteps.enterNewPassPhrase){
        this.service.model.newPassphrase = pass;
        if(this.service.model.bkpPassphrase != null) {
          if(this.service.model.bkpPassphrase == this.service.model.newPassphrase){
            this.service.setError(KeysModalError.repeatedPassprhase);
          }else {
            this.service.cycleKeysInBkpService();
          }
        }else{
          this.service.createKeysAndSave();
        }
      }else if(this.service.model.step == KeysModalSteps.enterBkpPassPhrase){
        this.service.model.bkpPassphrase = pass;
        this.service.recoverKeys();
      }
    }else{
      this.service.setError(KeysModalError.passphraseLength);
    }
  }

  void goToPinPassRecover() {
    this.service.enterBkpPincode();
  }

  void goToRecoverAccountQuestion() {
    this.service.recoverAccountQuestion();
  }

  void goToRecoverAccount(){
    this.service.recoverAccount();
  }

  void restart() {
    this.service.restart();
  }

  void back(BuildContext context) {
    switch(service.model.step){
      case KeysModalSteps.enterBkpPinCode:
      case KeysModalSteps.enterNewPinCode:
        this.restart();
        break;
      case KeysModalSteps.enterNewPassPhrase:
        this.goToCreateNewKeys();
        break;
      case KeysModalSteps.enterBkpPassPhrase:
        this.goToPinPassRecover();
        break;
      case KeysModalSteps.recoverAccountQuestion:
        this.goToCreateNewKeys();
        break;
      default:
        print('cannot go back from ' + service.model.step.toString());
        break;
    }
  }

  void close(BuildContext context){
    Navigator.of(context).pop();
  }

}
