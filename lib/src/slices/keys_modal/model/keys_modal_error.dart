enum KeysModalError {
  invalidQrCode,
  noConnection,
  pincodeLength,
  passphraseLength,
  repeatedPinCode,
  repeatedPassprhase,
  serverError,
  tooManyAttempts,
  wrongBkpPinCode,
  wrongBkpPassphrase,
}

extension KeysModalErrorMessage on KeysModalError {
  String? get message {
    switch (this) {
      case KeysModalError.invalidQrCode:
        return "Invalid QR code.";
      case KeysModalError.noConnection:
        return "Please check your internet connection.";
      case KeysModalError.repeatedPinCode:
        return "Please, use a different pin code.";
      case KeysModalError.repeatedPassprhase:
        return "Please use a different passphrase.";
      case KeysModalError.pincodeLength:
        return "Pin code should have exactly 6 digits.";
      case KeysModalError.passphraseLength:
        return "Passprhase should have more than 8 characters.";
      case KeysModalError.serverError:
        return "Internal error, please try again.";
      case KeysModalError.tooManyAttempts:
        return "Too Many Attempts. Please contact support.";
      case KeysModalError.wrongBkpPinCode:
        return "Invalid Pin Code.";
      case KeysModalError.wrongBkpPassphrase:
        return "Invalid Passphrase.";
    }
  }
}
