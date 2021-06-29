import 'package:app/src/slices/api/api_service.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:app/src/slices/keys/keys_service.dart';
import 'package:app/src/slices/keys/model/keys_model.dart';
import 'package:app/src/slices/keys_create_screen/keys_new_screen_controller.dart';
import 'package:app/src/slices/keys_create_screen/keys_new_screen_presenter.dart';
import 'package:app/src/slices/keys_create_screen/ui/keys_new_screen_restore.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeysNewScreenService extends ChangeNotifier {
  late KeysNewScreenPresenter presenter;
  late KeysNewScreenController controller;

  KeysNewScreenService() {
    presenter = KeysNewScreenPresenter(this);
    controller = KeysNewScreenController();
  }

  getUI() {
    return presenter.render();
  }

  void restoreKeys(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => KeysNewScreenRestore().getUI()));
  }

  generateKeys(BuildContext context) async {
    var keysService = KeysService();
    var apiService = ApiService();
    var appService = Provider.of<AppService>(context);
    KeysModel keys = await keysService.generateKeys();
    KeysModel keysWithAddress = await keysService.issueAddress(context, keys);
    await keysService.save(keysWithAddress);
    String referral = await apiService.getReferalCode(keysWithAddress.address!);
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
