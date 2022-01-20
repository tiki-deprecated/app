enum KeysModalSteps {
  enterBkpPinCode,
  enterNewPinCode,
  enterNewPassPhrase,
  enterBkpPassPhrase,
  generateKeys,
  newAccountQuestion,
  qrCodeQuestion,
  error,
}

extension KeysModalStepsTitle on KeysModalSteps {
  String? get title {
    switch (this) {
      case KeysModalSteps.newAccountQuestion:
        return "New Account";
      case KeysModalSteps.qrCodeQuestion:
        return "Scan QR Code";
      case KeysModalSteps.generateKeys:
        return "Creating the keys";
      case KeysModalSteps.enterBkpPinCode:
        return "Backup Pin code";
      case KeysModalSteps.enterNewPinCode:
        return "New Pin code";
      case KeysModalSteps.enterNewPassPhrase:
        return "New Passphrase";
      case KeysModalSteps.enterBkpPassPhrase:
        return "Backup Pass Phrase";
      case KeysModalSteps.error:
        return "Error";
    }
  }
}
