/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asn1.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256r1.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/ec_key_generator.dart';

import 'helper_crypto.dart';

class HelperCryptoEcdsa {
  static String encodeECDSAPublic(ECPublicKey publicKey) {
    ASN1Sequence sequence = ASN1Sequence();
    ASN1Sequence algorithm = ASN1Sequence();
    algorithm.add(ASN1ObjectIdentifier.fromName('ecPublicKey'));
    algorithm.add(ASN1ObjectIdentifier.fromName('prime256v1'));
    ASN1BitString publicKeyBitString = ASN1BitString();
    publicKeyBitString.stringValues = publicKey.Q!.getEncoded(false);
    sequence.add(algorithm);
    sequence.add(publicKeyBitString);
    sequence.encode();
    return base64.encode(sequence.encodedBytes!);
  }

  static String encodeECDSAPrivate(ECPrivateKey privateKey) {
    ASN1Sequence sequence = ASN1Sequence();
    ASN1Integer version = ASN1Integer(BigInt.from(0));
    ASN1Sequence algorithm = ASN1Sequence();
    algorithm.add(ASN1ObjectIdentifier.fromName('ecPublicKey'));
    algorithm.add(ASN1ObjectIdentifier.fromName('prime256v1'));

    ASN1Sequence encodedPrivateKey = ASN1Sequence();
    ASN1Integer encodedPrivateKeyVersion = ASN1Integer(BigInt.from(1));
    ASN1OctetString encodedPrivateKeyValue = ASN1OctetString();
    ASN1Integer encodePrivateKeyBigInt = ASN1Integer(privateKey.d);
    encodePrivateKeyBigInt.encode();
    encodedPrivateKeyValue.octets = encodePrivateKeyBigInt.valueBytes;
    encodedPrivateKey.add(encodedPrivateKeyVersion);
    encodedPrivateKey.add(encodedPrivateKeyValue);
    encodedPrivateKey.encode();

    ASN1OctetString privateKeyDer = ASN1OctetString();
    privateKeyDer.octets = encodedPrivateKey.encodedBytes;

    sequence.add(version);
    sequence.add(algorithm);
    sequence.add(privateKeyDer);
    sequence.encode();
    return base64.encode(sequence.encodedBytes!);
  }

  static Future<AsymmetricKeyPair<ECPublicKey, ECPrivateKey>>
      createECDSA() async {
    return await compute(_createECDSA, "").then((keyPair) => keyPair);
  }

  static AsymmetricKeyPair<ECPublicKey, ECPrivateKey> _createECDSA(var dummy) {
    final ECKeyGeneratorParameters keyGeneratorParameters =
        ECKeyGeneratorParameters(ECCurve_secp256r1());
    ECKeyGenerator ecKeyGenerator = ECKeyGenerator();
    ecKeyGenerator.init(ParametersWithRandom(
        keyGeneratorParameters, HelperCrypto.secureRandom()));
    AsymmetricKeyPair<PublicKey, PrivateKey> keyPair =
        ecKeyGenerator.generateKeyPair();
    return AsymmetricKeyPair<ECPublicKey, ECPrivateKey>(
        keyPair.publicKey as ECPublicKey, keyPair.privateKey as ECPrivateKey);
  }
}
