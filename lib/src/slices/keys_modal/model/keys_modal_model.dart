import 'keys_modal_steps.dart';

class KeysModalModel {
  KeysModalSteps step = KeysModalSteps.newAccountQuestion;

  String? rcvPassphrase;
  String? bkpPassphrase;
  String? rcvPincode;
  String? bkpPincode;

  String? error;

  get title => step.title;
}
