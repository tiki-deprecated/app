import 'package:app/src/slices/keys_create_screen/keys_create_screen_service.dart';
import 'package:app/src/slices/keys_create_screen/ui/keys_create_screen_layout.dart';
import 'package:provider/provider.dart';

class KeysCreateScreenPresenter {
  final KeysCreateScreenService service;

  KeysCreateScreenPresenter(this.service);

  ChangeNotifierProvider<KeysCreateScreenService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: KeysCreateScreenLayout());
  }
}
