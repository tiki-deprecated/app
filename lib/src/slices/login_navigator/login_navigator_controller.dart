import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/login_navigator/login_navigator_service.dart';
import 'package:provider/provider.dart';

class LoginNavigatorController {
  goToHome(context) {
    if (Provider.of<LoginNavigatorService>(context).model.canContinue)
      Provider.of<AppService>(context).goToHome();
  }

  goToSaveKeys(context) {
    if (Provider.of<LoginNavigatorService>(context).model.keysCreated)
      Provider.of<LoginNavigatorService>(context).goToSaveKeys();
  }

  goToRestoreKeys(context) {
    Provider.of<LoginNavigatorService>(context).goToRestoreKeys();
  }
}
