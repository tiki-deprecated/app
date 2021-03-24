/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:pointycastle/api.dart';

class HelperSecurityKeysModelKP<Public extends PublicKey,
    Private extends PrivateKey> {
  AsymmetricKeyPair<Public, Private> keyPair;
  String encodedPrivate;
  String encodedPublic;
}
