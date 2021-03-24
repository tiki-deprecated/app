/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:developer';

import 'package:app/src/features/security_keys_new/security_keys_new_model.dart';
import 'package:app/src/features/security_keys_new/security_keys_new_model_status.dart';
import 'package:app/src/repositories/security_keys/security_keys_model.dart';
import 'package:app/src/repositories/security_keys/security_keys_model_keypair.dart';
import 'package:app/src/utilities/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:rxdart/rxdart.dart';

class SecurityKeysNewBloc {
  SecurityKeysNewModel securityKeysNewModel;
  BehaviorSubject<SecurityKeysNewModel> _subjectModel;
  Function createCallback;

  SecurityKeysNewBloc() {
    securityKeysNewModel = SecurityKeysNewModel();
    _subjectModel = BehaviorSubject.seeded(securityKeysNewModel);
  }

  Observable<SecurityKeysNewModel> get observableModel => _subjectModel.stream;

  Future<SecurityKeysNewModel> create() async {
    if (securityKeysNewModel.status == SecurityKeysNewModelStatus.waiting ||
        securityKeysNewModel.status == SecurityKeysNewModelStatus.failed) {
      securityKeysNewModel.keys = SecurityKeysModel();
      _broadcastStatus(SecurityKeysNewModelStatus.pending);
      try {
        await compute(createECDSA, "").then((value) async {
          SecurityKeysNewModelKeyPair<ECPublicKey, ECPrivateKey> keyPair =
              SecurityKeysNewModelKeyPair();
          keyPair.keyPair = value;
          keyPair.encodedPublicKey = encodeECDSAPublic(value.publicKey);
          keyPair.encodedPrivateKey = encodeECDSAPrivate(value.privateKey);
          securityKeysNewModel.keys.signKeys = keyPair;
        });
        await compute(createRSA, "").then((value) {
          SecurityKeysNewModelKeyPair<RSAPublicKey, RSAPrivateKey> keyPair =
              SecurityKeysNewModelKeyPair();
          keyPair.keyPair = value;
          keyPair.encodedPublicKey = encodeRSAPublic(value.publicKey);
          keyPair.encodedPrivateKey = encodeRSAPrivate(value.privateKey);
          securityKeysNewModel.keys.dataKeys = keyPair;
        });
        securityKeysNewModel.keys.id =
            sha3(securityKeysNewModel.keys.signKeys.encodedPublicKey);
        _broadcastStatus(SecurityKeysNewModelStatus.complete);
      } catch (e) {
        log("Failed to create security keys", error: e);
        _broadcastStatus(SecurityKeysNewModelStatus.failed);
      }
    }
    return securityKeysNewModel;
  }

  void _broadcastStatus(SecurityKeysNewModelStatus status) {
    securityKeysNewModel.status = status;
    _subjectModel.sink.add(securityKeysNewModel);
  }

  void dispose() {
    _subjectModel.close();
  }
}
