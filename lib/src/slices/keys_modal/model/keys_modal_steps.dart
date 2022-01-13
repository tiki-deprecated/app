enum KeysModalSteps {
  enterPinCode,
  enterPassPhrase,
  generateKeys,
  newAccountQuestion,
  qrCodeQuestion,
  qrCodeScanner,
  cycleKeys
}

extension KeysModalStepsTitle on KeysModalSteps {
  String? get title {
    switch (this) {
      case KeysModalSteps.cycleKeys:
        return "New Account";
      case KeysModalSteps.newAccountQuestion:
        return "New Account";
      case KeysModalSteps.qrCodeQuestion:
        return "Scan QR Code";
      case KeysModalSteps.qrCodeScanner:
        return "QR Code Scanner";
      case KeysModalSteps.enterPinCode:
        return "Pin Code";
      case KeysModalSteps.enterPassPhrase:
        return "Passphrase";
      case KeysModalSteps.generateKeys:
        return "Creating the keys";
    }
  }
}
