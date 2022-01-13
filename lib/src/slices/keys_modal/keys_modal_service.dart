/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_user/model/api_user_model_keys.dart';
import 'package:app/src/slices/keys_modal/model/keys_modal_steps.dart';

import '../keys_create_screen/keys_create_screen_service.dart';
import 'package:flutter/widgets.dart';

import '../api_zendesk/api_zendesk_service.dart';
import 'keys_modal_controller.dart';
import 'keys_modal_presenter.dart';
import 'model/keys_modal_model.dart';

class KeysModalService extends ChangeNotifier {
  late final KeysModalPresenter presenter;
  late final KeysModalController controller;
  late final KeysModalModel model;
  final ApiZendeskService zendeskService = ApiZendeskService();

  KeysCreateScreenService keysCreateScreenService;

  KeysModalService(this.keysCreateScreenService) {
    this.presenter = KeysModalPresenter(this);
    this.controller = KeysModalController(this);
    this.model = KeysModalModel();
  }

  bool canSubmit() {
    if (model.combinedKeys != null)
      return model.combinedKeys!.length == 1782;
    else
      return false;
  }

  void updateCombinedKeys(String keys) {
    this.model.combinedKeys = keys;
    notifyListeners();
  }

  Future<void> saveAndLogin() async {
    ApiUserModelKeys? keys = _getKeysFromCombined(this.model.combinedKeys!);
    // FIXME loginflowservice should be available here
    if (keys != null) await this.keysCreateScreenService.loginFlowService.saveAndLogin(keys: keys);
  }

  ApiUserModelKeys? _getKeysFromCombined(String combined) {
    List<String> combinedSplit = combined.split(".");
    String address = combinedSplit[0];
    String dataKey = combinedSplit[1];
    String signKey = combinedSplit[2];

    if (_areKeysValid(address, dataKey, signKey)) {
      return ApiUserModelKeys(
        dataPrivateKey: dataKey,
        signPrivateKey: signKey,
        address: address,
      );
    }
    return null;
  }

  bool _areKeysValid(
      String? address, String? dataKeyPrivate, String? signKeyPrivate) {
    var addressValid = address != null && address.length == 64;
    var dataKeyValid = dataKeyPrivate != null && dataKeyPrivate.length == 1624;
    var signKeyValid = signKeyPrivate != null && signKeyPrivate.length == 92;
    return addressValid && dataKeyValid && signKeyValid;
  }

  void startKeysCreation() {
    this.model.combinedKeys = null;
    this.model.step = KeysModalSteps.enterPinCode;
    notifyListeners();
  }

  void startPincode() {
    this.model.pincode = null;
    this.model.step = KeysModalSteps.enterPinCode;
    notifyListeners();
  }

  //todo
  bool verifyPincode(int pin){
    return true;
  }

  //todo
  bool verifyPassphrase(String pass){
    return true;
  }

  void startPassphraseWithPin(int pin) {
    this.model.pincode = pin;
    this.model.step = KeysModalSteps.enterPassPhrase;
    notifyListeners();
  }

  void createKeysAndSaveWithPass(String pass) {}

  void pincodeError() {
    this.model.error = "Invalid pincode";
  }

  void passphraseError() {
    this.model.error = "Invalid passphrase";
    notifyListeners();
  }

  void goToKeysScanQuestion() {
    this.model.step = KeysModalSteps.qrCodeQuestion;
    notifyListeners();
  }

}
