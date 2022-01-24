enum KeysModalSteps {
  enterBkpPinCode,
  enterNewPinCode,
  enterNewPassPhrase,
  enterBkpPassPhrase,
  generateKeys,
  newAccountQuestion,
  recoverAccountQuestion,
  error,
}

extension KeysModalStepsTitle on KeysModalSteps {
  String? get title {
    switch (this) {
      case KeysModalSteps.newAccountQuestion:
        return "Hi!";
      case KeysModalSteps.recoverAccountQuestion:
        return "Welcome back!";
      case KeysModalSteps.generateKeys:
        return "Creating the keys...";
      case KeysModalSteps.enterBkpPassPhrase:
        return "Backup Pass Phrase";
      case KeysModalSteps.enterBkpPinCode:
        return "Backup Pin code";
      case KeysModalSteps.enterNewPassPhrase:
        return "New Passphrase";
      case KeysModalSteps.enterNewPinCode:
        return "New Pin code";
      case KeysModalSteps.error:
        return "Uh-oh!";
    }
  }
}
