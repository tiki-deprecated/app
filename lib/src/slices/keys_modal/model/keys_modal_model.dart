import 'keys_modal_error.dart';
import 'keys_modal_steps.dart';

class KeysModalModel {
  bool isVisible = false;
  KeysModalSteps step = KeysModalSteps.newAccountQuestion;
  get title => step.title;
  String? newPassphrase;
  String? bkpPassphrase;
  String? newPincode;
  String? bkpPincode;
  KeysModalError? error;
  get errorMessage => error?.message;
}
