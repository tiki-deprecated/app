/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repositories/security_keys/security_keys_model_keypair.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/ecc/api.dart';

class SecurityKeysModel {
  String email;
  String id;
  SecurityKeysNewModelKeyPair<ECPublicKey, ECPrivateKey> signKeys;
  SecurityKeysNewModelKeyPair<RSAPublicKey, RSAPrivateKey> dataKeys;
}
