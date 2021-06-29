import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
import 'package:app/src/slices/keys_save_screen/ui/keys_save_screen_layout.dart';
import 'package:provider/provider.dart';

class KeysSaveScreenPresenter {
  final service;

  KeysSaveScreenPresenter(this.service);

  ChangeNotifierProvider<KeysSaveScreenService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: KeysSaveScreenLayout());
  }
}
