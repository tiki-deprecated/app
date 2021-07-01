import 'package:app/src/slices/keys_create_screen/keys_new_screen_service.dart';
import 'package:app/src/slices/keys_create_screen/ui/keys_new_screen_layout.dart';
import 'package:provider/provider.dart';

class KeysNewScreenPresenter {
  final KeysNewScreenService service;

  KeysNewScreenPresenter(this.service);

  ChangeNotifierProvider<KeysNewScreenService> render() {
    return ChangeNotifierProvider.value(value: service, child: KeysNewScreen());
  }
}
