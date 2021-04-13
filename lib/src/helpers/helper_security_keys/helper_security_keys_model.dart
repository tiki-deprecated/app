/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/ecc/api.dart';

import 'helper_security_keys_model_kp.dart';

class HelperSecurityKeysModel {
  String address;
  HelperSecurityKeysModelKP<RSAPublicKey, RSAPrivateKey> dataKey;
  HelperSecurityKeysModelKP<ECPublicKey, ECPrivateKey> signKey;

  HelperSecurityKeysModel()
      : this.signKey = HelperSecurityKeysModelKP<ECPublicKey, ECPrivateKey>(),
        this.dataKey = HelperSecurityKeysModelKP<RSAPublicKey, RSAPrivateKey>();
}
