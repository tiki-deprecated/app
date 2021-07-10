import 'package:app/src/slices/home_navigator/home_navigator_service.dart';

class HomeNavigatorController {
  goTo(int i, HomeNavigatorService service) {
    service.goTo(i);
  }
}
