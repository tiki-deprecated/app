/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../login_flow/login_flow_service.dart';

import 'model/keys_modal_steps.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wallet/wallet.dart';

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
  late final LoginFlowService loginFlowService;

  KeysModalService(this.loginFlowService) {
    this.presenter = KeysModalPresenter(this);
    this.controller = KeysModalController(this);
    this.model = KeysModalModel();
    _tikiKeysService = TikiKeysService(secureStorage: FlutterSecureStorage());
    _tikiBkupService = TikiBkupService(tikiKeysService: _tikiKeysService);
  }

  void enterNewPinCode() {
    this.model.step = KeysModalSteps.enterNewPinCode;
    notifyListeners();
  }

  void enterNewPassphrase() {
    this.model.step = KeysModalSteps.enterNewPassPhrase;
    notifyListeners();
  }

  Future<void> createKeysAndSave() async {
    this.model.step = KeysModalSteps.generateKeys;
    try {
      String email = this.loginFlowService.model.user!.user!.email!;
      String accessToken = this.loginFlowService.model.user!.token!.bearer!;
      TikiKeysModel keys = await _tikiKeysService.generate();
      await _tikiBkupService.backup(
          email: email,
          accessToken: accessToken,
          pin: this.model.newPincode!,
          passphrase: this.model.newPassphrase!,
          keys: keys,
          onSuccess: () {
            this.login(keys.address);
          },
          onError: (error) {
            throw(error);
          }
      );
    }catch(e){
      print(e); // TODO add error control
    }
  }

  void enterBkpPincode() {
    this.model.step = KeysModalSteps.enterBkpPinCode;
    notifyListeners();
  }

  void enterBkpPassphrase() {
    this.model.step = KeysModalSteps.enterBkpPassPhrase;
    notifyListeners();
  }

  Future<void> recoverKeys() async {
    String email = this.loginFlowService.model.user!.user!.email!;
    String accessToken = this.loginFlowService.model.user!.token!.bearer!;
    await _tikiBkupService.recover(
        email: email,
        accessToken: accessToken,
        pin: this.model.bkpPincode.toString(),
        passphrase: this.model.bkpPassphrase!,
        onSuccess: (keys) async {
          await _tikiKeysService.provide(keys);
          this.enterBkpPincode();
        },
        onError: (error) {
          print('error');
        }
    );
  }

  Future<void> cycleKeysInBkpService(pin, pass) async {
    String email = this.loginFlowService.model.user!.user!.email!;
    String accessToken = this.loginFlowService.model.user!.token!.bearer!;
    TikiKeysModel? keys = await _tikiKeysService.get(this.loginFlowService.model.user!.user!.address!);
    await _tikiBkupService.cycle(
        email: email,
        accessToken: accessToken,
        oldPin: this.model.bkpPincode!,
        newPin: this.model.newPincode!,
        passphrase: this.model.bkpPassphrase!,
        keys: keys!,
        onSuccess: () {
          this.login(keys.address);
        },
        onError: (error) {
          print('error');
        }
    );
  }

  void pincodeError() {
    this.model.error = "Invalid pincode";
    notifyListeners();
  }

  void passphraseError() {
    this.model.error = "Invalid passphrase";
    notifyListeners();
  }

  bool checkPinCode(String pin){
    if(pin.length != 6) return false;
    return true;
  }

  bool checkPassphrase(String pass){
    if(pass.length < 8) return false;
    return true;
  }

  void goToKeysScanQuestion() {
    this.model.step = KeysModalSteps.qrCodeQuestion;
    notifyListeners();
  }

  void provideKeys(TikiKeysModel keys) async {
    await _tikiKeysService.provide(keys);
    notifyListeners();
  }

  Future<void> login(String address) async {
    this.loginFlowService.saveAndLogin(address: address);
  }



}
