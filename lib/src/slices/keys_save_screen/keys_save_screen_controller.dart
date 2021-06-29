import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model_routes.dart';
import 'package:provider/provider.dart';

class KeysSaveScreenController {
  goToHome(context) {
    AppService appService = Provider.of<AppService>(context);
    appService.home = AppModelRoutes.home;
    appService.reload();
  }
}
