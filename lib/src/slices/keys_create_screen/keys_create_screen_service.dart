import 'package:app/src/slices/api/api_service.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:app/src/slices/keys/keys_service.dart';
import 'package:app/src/slices/keys/model/keys_model.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_controller.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_presenter.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/keys_create_screen_model.dart';

class KeysCreateScreenService extends ChangeNotifier {
  late KeysCreateScreenPresenter presenter;
  late KeysCreateScreenController controller;
  late KeysCreateScreenModel model;

  KeysCreateScreenService() {
    presenter = KeysCreateScreenPresenter(this);
    controller = KeysCreateScreenController();
    model = KeysCreateScreenModel();
  }

  getUI() {
    return presenter.render();
  }

  generateKeys(BuildContext context) async {
    if (!model.isStarted) {
      model.isStarted = true;
      var keysService = KeysService();
      var apiService = ApiService();
      var appService = Provider.of<AppService>(context);
      KeysModel keys = await keysService.generateKeys();
      KeysModel keysWithAddress = await keysService.issueAddress(context, keys);
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
      await Future.delayed(Duration(seconds: 3));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => KeysSaveScreenService().getUI()),
          ModalRoute.withName('/keys/save'));
    }
  }
}
