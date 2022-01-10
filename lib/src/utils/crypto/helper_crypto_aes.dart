/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

import 'helper_crypto.dart';

class HelperCryptoAes {
  static String encrypt(String password, String salt, String plaintext) {
    Uint8List derivedKey = _deriveKey(password, salt);
    KeyParameter keyParam = new KeyParameter(derivedKey);
    BlockCipher aes = new AESFastEngine();
    Uint8List iv = HelperCrypto.secureRandom().nextBytes(aes.blockSize);

    Uint8List plaintextBytes = utf8.encode(plaintext) as Uint8List;
    PKCS7Padding pad = new PKCS7Padding()..init(null);
    int padLength = aes.blockSize - (plaintextBytes.length % aes.blockSize);
    Uint8List plaintextBytesPadded =
        new Uint8List(plaintextBytes.length + padLength)
          ..setAll(0, plaintextBytes);
    pad.addPadding(plaintextBytesPadded, plaintextBytes.length);

    CBCBlockCipher cipher = new CBCBlockCipher(aes)
      ..init(true, new ParametersWithIV(keyParam, iv));
    Uint8List cipherBytes = _processBlocks(cipher, plaintextBytesPadded);
    Uint8List cipherIvBytes = new Uint8List(cipherBytes.length + iv.length)
      ..setAll(0, iv)
      ..setAll(iv.length, cipherBytes);

    return base64.encode(cipherIvBytes);
  }

  static String decrypt(String password, String salt, String encryptedText) {
    Uint8List derivedKey = _deriveKey(password, salt);
    KeyParameter keyParam = new KeyParameter(derivedKey);
    BlockCipher aes = new AESFastEngine();

    Uint8List eTextIvBytes = base64.decode(encryptedText);
    Uint8List iv = new Uint8List(aes.blockSize)
      ..setRange(0, aes.blockSize, eTextIvBytes);

    BlockCipher cipher = new CBCBlockCipher(aes)
      ..init(false, new ParametersWithIV(keyParam, iv));

    int eTextIvLength = eTextIvBytes.length - aes.blockSize;
    Uint8List eTextBytes = new Uint8List(eTextIvLength)
      ..setRange(0, eTextIvLength, eTextIvBytes, aes.blockSize);
    Uint8List paddedText = _processBlocks(cipher, eTextBytes);

    PKCS7Padding pad = new PKCS7Padding()..init(null);
    int padLength = pad.padCount(paddedText);
    int len = paddedText.length - padLength;
    Uint8List textBytes = new Uint8List(len)..setRange(0, len, paddedText);
    return utf8.decode(textBytes);
  }

  static Uint8List _deriveKey(String password, String salt) {
    Pbkdf2Parameters params =
        new Pbkdf2Parameters(utf8.encode(salt) as Uint8List, 1000, 32);
    KeyDerivator keyDerivator =
        new PBKDF2KeyDerivator(new HMac(new SHA256Digest(), 64));
    keyDerivator.init(params);
    return keyDerivator.process(utf8.encode(password) as Uint8List);
  }

  static Uint8List _processBlocks(BlockCipher cipher, Uint8List inp) {
    var out = new Uint8List(inp.lengthInBytes);
    for (var offset = 0; offset < inp.lengthInBytes;) {
      var len = cipher.processBlock(inp, offset, out, offset);
      offset += len;
    }
    return out;
  }
}
