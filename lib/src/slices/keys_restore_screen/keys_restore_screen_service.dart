/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import '../api_user/model/api_user_model_keys.dart';
import '../login_flow/login_flow_service.dart';
import 'keys_restore_screen_controller.dart';
import 'keys_restore_screen_presenter.dart';
import 'model/keys_restore_screen_model.dart';

class KeysRestoreScreenService extends ChangeNotifier {
  late KeysRestoreScreenPresenter presenter;
  late KeysRestoreScreenController controller;
  late KeysRestoreScreenServiceModel model;
  final LoginFlowService loginFlowService;

  KeysRestoreScreenService(this.loginFlowService) {
    model = KeysRestoreScreenServiceModel();
    presenter = KeysRestoreScreenPresenter(this);
    controller = KeysRestoreScreenController(this);
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
    if (keys != null) await loginFlowService.saveAndLogin(keys: keys);
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
}
