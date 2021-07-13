import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/intro_screen/intro_screen_service.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_service.dart';
import 'package:app/src/slices/keys_restore_screen/keys_restore_screen_service.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
import 'package:app/src/slices/login_navigator/login_navigator_service.dart';
import 'package:app/src/slices/login_navigator/model/login_navigator_model.dart';
import 'package:app/src/slices/login_screen/login_screen_email_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appService = context.watch<AppService>();
    var loginNavigatorService = context.watch<LoginNavigatorService>();
    return Navigator(
        pages: [
          if (!appService.isReturning()) IntroScreenService().getUI(),
          if (appService.model.user != null &&
              appService.model.user!.isLoggedIn!)
            LoginScreenService().getUI(),
          if (loginNavigatorService.model.currentScreen ==
              LoginNavigatorModel.createKeys)
            KeysCreateScreenService(appService).getUI(),
          if (loginNavigatorService.model.currentScreen ==
              LoginNavigatorModel.saveKeys)
            KeysSaveScreenService().getUI(),
          if (loginNavigatorService.model.currentScreen ==
              LoginNavigatorModel.restoreKeys)
            KeysRestoreScreenService(appService).getUI(),
        ],
        onPopPage: (Route route, result) {
          return route.didPop(result);
        });
  }
}
