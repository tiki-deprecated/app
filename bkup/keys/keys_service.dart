import 'package:app/src/slices/api/helpers/helper_api_rsp.dart';
import 'package:app/src/slices/blockchain/model/blockchain_model_address_req.dart';
import 'package:app/src/slices/blockchain/model/blockchain_model_address_rsp.dart';
import 'package:app/src/slices/blockchain/repository/blockchain_repository_address.dart';
import 'package:app/src/slices/keys/repository/secure_storage_repository_keys.dart';
import 'package:app/src/utils/crypto/helper_crypto.dart';
import 'package:app/src/utils/crypto/helper_crypto_ecdsa.dart';
import 'package:app/src/utils/crypto/helper_crypto_rsa.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'model/keys_model.dart';

class KeysService {
  SecureStorageRepositoryKeys _repoLocalSsKeys;

  KeysService()
      : _repoLocalSsKeys =
            SecureStorageRepositoryKeys(secureStorage: FlutterSecureStorage());

  /// Verify if credentials are valid
  ///
  /// Checks if any of the keys are null and if they have the correct length.
  bool isKeyValid(
      String? address, String? dataKeyPrivate, String? signKeyPrivate) {
    var addressValid = address != null && address.length == 64;
    var dataKeyValid = dataKeyPrivate != null && dataKeyPrivate.length == 1624;
    var signKeyValid = signKeyPrivate != null && signKeyPrivate.length == 92;
    return addressValid && dataKeyValid && signKeyValid;
  }

  Future<void> saveWitParams(String address, String? dataPrivate,
      String? signPrivate, String? dataPublicKey, String? signPublicKey) async {
    await _repoLocalSsKeys.save(
        address,
        KeysModel(
            address: address,
            dataPrivateKey: dataPrivate,
            dataPublicKey: dataPublicKey,
            signPrivateKey: signPrivate,
            signPublicKey: signPublicKey));
  }

  Future<void> save(KeysModel keys) async {
    await _repoLocalSsKeys.save(keys.address!, keys);
  }

  Future<KeysModel> issueAddress(KeysModel keys) async {
    var repoApiBlockchainAddress = BlockchainRepositoryAddress.provide();
    HelperApiRsp<BlockchainModelAddressRsp> rsp =
        await repoApiBlockchainAddress.issue(
            BlockchainModelAddressReq(keys.dataPublicKey, keys.signPublicKey));
    if (rsp.code == 200 && rsp.data.address == keys.address) {
      await _repoLocalSsKeys.save(keys.address!, keys);
    } else {
      Sentry.captureMessage("Failed to register keys with blockchain",
          level: SentryLevel.error);
      return KeysModel();
    }
    return keys;
  }

  String getAddress(String s) {
    List<String> raw = s.split(".");
    return raw[0];
  }

  String getDataKey(String s) {
    List<String> raw = s.split(".");
    return raw[1];
  }

  String getSignKey(String s) {
    List<String> raw = s.split(".");
    return raw[2];
  }

  generateKeys() async {
    AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> dataKey =
        await HelperCryptoRsa.createRSA();
    AsymmetricKeyPair<ECPublicKey, ECPrivateKey> signKey =
        await HelperCryptoEcdsa.createECDSA();
    String dataPublic = HelperCryptoRsa.encodeRSAPublic(dataKey.publicKey);
    String dataPrivate = HelperCryptoRsa.encodeRSAPrivate(dataKey.privateKey);
    String signPublic = HelperCryptoEcdsa.encodeECDSAPublic(signKey.publicKey);
    String signPrivate =
        HelperCryptoEcdsa.encodeECDSAPrivate(signKey.privateKey);
    String address = HelperCrypto.sha3(signPublic);
    return KeysModel(
      dataPublicKey: dataPublic,
      dataPrivateKey: dataPrivate,
      signPublicKey: signPublic,
      signPrivateKey: signPrivate,
      address: address,
    );
  }

  getKeys(String address) async {
    return await _repoLocalSsKeys.find(address);
  }

  KeysModel? getKeysFromCombined(String rawContent) {
    String address = getAddress(rawContent);
    String dataKey = getDataKey(rawContent);
    String signKey = getSignKey(rawContent);
    if (isKeyValid(address, dataKey, signKey)) {
      return KeysModel(
        dataPrivateKey: dataKey,
        signPrivateKey: signKey,
        address: address,
      );
    }
    return null;
  }

  Future<KeysModel> generateKeysAndIssueAddress() async {
    KeysModel keys = await generateKeys();
    KeysModel keysWithAddress = await issueAddress(keys);
    if (keysWithAddress.address != null) {
      await save(keysWithAddress);
    }
    return keysWithAddress;
  }
}
