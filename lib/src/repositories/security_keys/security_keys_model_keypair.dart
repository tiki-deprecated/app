/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:pointycastle/api.dart';

class SecurityKeysNewModelKeyPair<Public extends PublicKey,
    Private extends PrivateKey> {
  AsymmetricKeyPair<Public, Private> keyPair;
  String encodedPrivateKey;
  String encodedPublicKey;
}
