import 'package:app/src/slices/api/api_service.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:app/src/slices/keys/keys_service.dart';
import 'package:app/src/slices/keys/model/keys_model.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_controller.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_presenter.dart';
import 'package:flutter/material.dart';

import 'model/keys_create_screen_model.dart';

class KeysCreateScreenService extends ChangeNotifier {
  late KeysCreateScreenPresenter presenter;
  late KeysCreateScreenController controller;
  late KeysCreateScreenModel model;

  AppService appService;

  KeysCreateScreenService(this.appService) {
    presenter = KeysCreateScreenPresenter(this);
    controller = KeysCreateScreenController();
    model = KeysCreateScreenModel();
  }

  getUI() {
    generateKeys();
    return presenter.render();
  }

  generateKeys() async {
    if (!model.isStarted) {
      setStarted(true);
      var keysService = KeysService();
      var apiService = ApiService();
      KeysModel keys = await keysService.generateKeys();
      KeysModel keysWithAddress = await keysService.issueAddress(keys);
      await keysService.save(keysWithAddress);
      String referral =
          await apiService.getReferalCode(keysWithAddress.address!);
      AppModelUser user = AppModelUser(
        email: appService.model.current!.email,
        address: keysWithAddress.address,
        isLoggedIn: true,
        code: referral,
      );
      appService.updateUser(user);
      await Future.delayed(Duration(
          seconds:
              3)); //TODO this should wait at least 3 seconds, not add 3 seconds to every generate
    }
  }

  void setStarted(bool state) {
    model.isStarted = state;
    notifyListeners();
  }

  void setComplete(bool state) {
    model.isComplete = state;
    notifyListeners();
  }
}
