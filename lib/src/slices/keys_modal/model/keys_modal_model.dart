import 'keys_modal_steps.dart';

class KeysModalModel {
  KeysModalSteps step = KeysModalSteps.newAccountQuestion;

  get title => step.title;
}
