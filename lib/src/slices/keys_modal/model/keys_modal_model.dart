import 'keys_modal_steps.dart';

class KeysModalModel {
  KeysModalSteps step = KeysModalSteps.newAccountQuestion;

  String? newPassphrase;
  String? bkpPassphrase;
  String? newPincode;
  String? bkpPincode;

  String? error;

  get title => step.title;
}
