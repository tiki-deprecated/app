enum KeysModalSteps {
  newAccountQuestion,
  qrCodeQuestion,
  qrCodeScanner,
  enterPinCode,
  enterPassPhrase
}

extension KeysModalStepsTitle on KeysModalSteps {
  String? get title {
    switch (this) {
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
    }
  }
}
