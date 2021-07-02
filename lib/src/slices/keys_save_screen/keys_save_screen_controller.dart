import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model_routes.dart';
import 'package:app/src/slices/keys_restore_screen/keys_restore_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class KeysSaveScreenController {
  goToHome(context) {
    AppService appService = Provider.of<AppService>(context);
    appService.home = AppModelRoutes.home;
    appService.reload();
  }

  goToRestore(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => KeysRestoreScreenService().getUI()));
  }
}
