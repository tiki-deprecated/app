/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/asn1.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/digests/sha3.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256r1.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/ec_key_generator.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';

FortunaRandom secureRandom() {
  var secureRandom = new FortunaRandom();
  var random = new Random.secure();
  //List<int> seeds = List<int>.generate(32, (i) => random.nextInt(255));
  final seeds = <int>[];
  for (int i = 0; i < 32; i++) {
    seeds.add(random.nextInt(255));
  }
  secureRandom.seed(new KeyParameter(new Uint8List.fromList(seeds)));
  return secureRandom;
}

String encodeECDSAPublic(ECPublicKey publicKey) {
  ASN1Sequence sequence = ASN1Sequence();
  ASN1Sequence algorithm = ASN1Sequence();
  algorithm.add(ASN1ObjectIdentifier.fromName('ecPublicKey'));
  algorithm.add(ASN1ObjectIdentifier.fromName('prime256v1'));
  ASN1BitString publicKeyBitString = ASN1BitString();
  publicKeyBitString.stringValues = publicKey.Q.getEncoded(false);
  sequence.add(algorithm);
  sequence.add(publicKeyBitString);
  sequence.encode();
  return base64.encode(sequence.encodedBytes);
}

String encodeECDSAPrivate(ECPrivateKey privateKey) {
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
  return base64.encode(sequence.encodedBytes);
}

String encodeRSAPublic(RSAPublicKey publicKey) {
  ASN1Sequence sequence = ASN1Sequence();
  ASN1Sequence algorithm = ASN1Sequence();
  ASN1Object paramsAsn1Obj =
      ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));
  algorithm
      .add(ASN1ObjectIdentifier.fromIdentifierString('1.2.840.113549.1.1.1'));
  algorithm.add(paramsAsn1Obj);

  ASN1Sequence publicKeySequence = ASN1Sequence();
  ASN1Integer modulus = ASN1Integer(publicKey.modulus);
  ASN1Integer exponent = ASN1Integer(publicKey.exponent);
  publicKeySequence.add(modulus);
  publicKeySequence.add(exponent);
  publicKeySequence.encode();
  ASN1BitString publicKeyBitString = ASN1BitString();
  publicKeyBitString.stringValues = publicKeySequence.encodedBytes;

  sequence.add(algorithm);
  sequence.add(publicKeyBitString);
  sequence.encode();
  return base64.encode(sequence.encodedBytes);
}

String encodeRSAPrivate(RSAPrivateKey privateKey) {
  ASN1Sequence sequence = ASN1Sequence();
  ASN1Integer version = ASN1Integer(BigInt.from(0));
  ASN1Sequence algorithm = ASN1Sequence();
  ASN1Object paramsAsn1Obj =
      ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));
  algorithm
      .add(ASN1ObjectIdentifier.fromIdentifierString('1.2.840.113549.1.1.1'));
  algorithm.add(paramsAsn1Obj);

  ASN1Sequence privateKeySequence = ASN1Sequence();
  ASN1Integer privateKeyVersion = ASN1Integer(BigInt.from(1));
  ASN1Integer modulus = ASN1Integer(privateKey.modulus);
  ASN1Integer publicExponent = ASN1Integer(privateKey.publicExponent);
  ASN1Integer privateExponent = ASN1Integer(privateKey.privateExponent);
  ASN1Integer prime1 = ASN1Integer(privateKey.p);
  ASN1Integer prime2 = ASN1Integer(privateKey.q);
  ASN1Integer exponent1 =
      ASN1Integer(privateKey.privateExponent % (privateKey.p - BigInt.from(1)));
  ASN1Integer exponent2 =
      ASN1Integer(privateKey.privateExponent % (privateKey.q - BigInt.from(1)));
  ASN1Integer coefficient = ASN1Integer(privateKey.q.modInverse(privateKey.p));
  privateKeySequence.add(privateKeyVersion);
  privateKeySequence.add(modulus);
  privateKeySequence.add(publicExponent);
  privateKeySequence.add(privateExponent);
  privateKeySequence.add(prime1);
  privateKeySequence.add(prime2);
  privateKeySequence.add(exponent1);
  privateKeySequence.add(exponent2);
  privateKeySequence.add(coefficient);
  privateKeySequence.encode();
  ASN1OctetString privateKeyOctet = ASN1OctetString();
  privateKeyOctet.octets = privateKeySequence.encodedBytes;

  sequence.add(version);
  sequence.add(algorithm);
  sequence.add(privateKeyOctet);
  sequence.encode();
  return base64.encode(sequence.encodedBytes);
}

AsymmetricKeyPair<ECPublicKey, ECPrivateKey> createECDSA(var dummy) {
  final ECKeyGeneratorParameters keyGeneratorParameters =
      ECKeyGeneratorParameters(ECCurve_secp256r1());
  ECKeyGenerator ecKeyGenerator = ECKeyGenerator();
  ecKeyGenerator
      .init(ParametersWithRandom(keyGeneratorParameters, secureRandom()));
  AsymmetricKeyPair<PublicKey, PrivateKey> keyPair =
      ecKeyGenerator.generateKeyPair();
  return AsymmetricKeyPair<ECPublicKey, ECPrivateKey>(
      keyPair.publicKey as ECPublicKey, keyPair.privateKey as ECPrivateKey);
}

AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> createRSA(var dummy) {
  final keyGen = RSAKeyGenerator()
    ..init(ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 64),
        secureRandom()));
  AsymmetricKeyPair<PublicKey, PrivateKey> keyPair = keyGen.generateKeyPair();
  return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(
      keyPair.publicKey as RSAPublicKey, keyPair.privateKey as RSAPrivateKey);
}

String sha3(String raw) {
  final SHA3Digest sha3256 = SHA3Digest(256);
  Uint8List hash = sha3256.process(utf8.encode(raw));
  return hash.map((b) => '${b.toRadixString(16).padLeft(2, '0')}').join("");
}
