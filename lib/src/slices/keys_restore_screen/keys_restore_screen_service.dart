/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api/api_service.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:app/src/slices/keys/keys_service.dart';
import 'package:app/src/slices/keys/model/keys_model.dart';
import 'package:app/src/slices/keys_restore_screen/keys_restore_screen_controller.dart';
import 'package:app/src/slices/keys_restore_screen/keys_restore_screen_presenter.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/keys_restore_screen_model.dart';

class KeysRestoreScreenService extends ChangeNotifier {
  late KeysRestoreScreenPresenter presenter;
  late KeysRestoreScreenController controller;
  late KeysRestoreScreenServiceModel model;

  KeysRestoreScreenService() {
    model = KeysRestoreScreenServiceModel();
    presenter = KeysRestoreScreenPresenter(this);
    controller = KeysRestoreScreenController();
  }

  getUI() {
    return presenter.render();
  }

  void setManualKey(String s) {
    model.manualKeys = s;
    notifyListeners();
  }

  bool canSubmit() {
    if (model.manualKeys != null)
      return model.manualKeys!.length == 1782;
    else
      return false;
  }

  saveAndLogin(String combinedKeys, BuildContext context) async {
    var keysService = KeysService();
    KeysModel? keys = keysService.getKeysFromCombined(combinedKeys);
    if(keys != null ) {
      await keysService.save(keys!);
      var apiService = ApiService();
      var appService = Provider.of<AppService>(context);
      String referral = await apiService.getReferalCode(keys.address!);
      AppModelUser user = AppModelUser(
        email: appService.model.current!.email,
        address: keys.address,
        isLoggedIn: true,
        code: referral,
      );
      appService.updateUser(user);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => TikiScreenService().getUI()),
          ModalRoute.withName('/home'));
    }
  }
}
