import 'keys_modal_steps.dart';

class KeysModalModel {
  KeysModalSteps step = KeysModalSteps.newAccountQuestion;

  String? combinedKeys;

  String? passphrase;

  int? pincode;

  String? error;

  get title => step.title;
}
