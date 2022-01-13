/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_user/model/api_user_model_keys.dart';
import 'model/keys_modal_steps.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wallet/wallet.dart';

import '../keys_create_screen/keys_create_screen_service.dart';
import 'package:flutter/widgets.dart';

import 'keys_modal_controller.dart';
import 'keys_modal_presenter.dart';
import 'model/keys_modal_model.dart';

class KeysModalService extends ChangeNotifier {
  late final KeysModalPresenter presenter;
  late final KeysModalController controller;
  late final KeysModalModel model;
  late final TikiKeysService _tikiKeysService;
  late final TikiBkupService _tikiBkupService;
  KeysCreateScreenService keysCreateScreenService;

  KeysModalService(this.keysCreateScreenService) {
    this.presenter = KeysModalPresenter(this);
    this.controller = KeysModalController(this);
    this.model = KeysModalModel();
    _tikiKeysService = TikiKeysService(secureStorage: FlutterSecureStorage());
    _tikiBkupService = TikiBkupService(tikiKeysService: _tikiKeysService);

  }

  void startKeysCreation() {
    this.model.step = KeysModalSteps.enterPinCode;
    notifyListeners();
  }

  void startPincode() {
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
    this.model.bkpPincode = pin.toString();
    this.model.step = KeysModalSteps.enterPassPhrase;
    notifyListeners();
  }

  Future<void> createKeysAndSaveWithPass(String pass) async {
    this.model.step = KeysModalSteps.generateKeys;
    this.model.bkpPassphrase = pass;
    try {
      String email = this.keysCreateScreenService.loginFlowService.model.user!
          .user!.email!;
      String accessToken = this.keysCreateScreenService.loginFlowService.model
          .user!.token!.bearer!;
      TikiKeysModel keys = await _tikiKeysService.generate();
      await _tikiBkupService.backup(
          email: email,
          accessToken: accessToken,
          pin: this.model.bkpPincode.toString(),
          passphrase: this.model.bkpPassphrase!,
          keys: keys,
          onSuccess: _login,
          onError: _handle
      );
    }catch(e){
      print(e);
    }
  }

  Future<void> recoverKeysWithPass(pin, pass) async {
    String email = this.keysCreateScreenService.loginFlowService.model.user!
        .user!.email!;
    String accessToken = this.keysCreateScreenService.loginFlowService.model
        .user!.token!.bearer!;
    await _tikiBkupService.recover(
        email: email,
        accessToken: accessToken,
        pin: this.model.rcvPincode.toString(),
        passphrase: this.model.rcvPassphrase!,
        onSuccess: (keys) async {
          await _tikiKeysService.provide(keys);
          this.cycleKeys();
        },
        onError: _handle
    );
  }

  Future<void> cycleKeysInBkpService(pin, pass) async {
    String email = this.keysCreateScreenService.loginFlowService.model.user!
        .user!.email!;
    String accessToken = this.keysCreateScreenService.loginFlowService.model
        .user!.token!.bearer!;
    TikiKeysModel? keys = await _tikiKeysService.get(this.keysCreateScreenService.loginFlowService.model.user!.keys!.address!);
    await _tikiBkupService.cycle(
        email: email,
        accessToken: accessToken,
        oldPin: this.model.rcvPincode!,
        newPin: this.model.bkpPincode!,
        passphrase: this.model.bkpPassphrase!,
        keys: keys!,
        onSuccess: _login,
        onError: _handle
    );
  }

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

  void cycleKeys() {
    this.model.step = KeysModalSteps.cycleKeys;
    notifyListeners();
  }


  _login() {
  }

  _handle(Object p1) {
  }

  void provideKeys(TikiKeysModel keys) async {
    await _tikiKeysService.provide(keys);
    notifyListeners();
  }
}
