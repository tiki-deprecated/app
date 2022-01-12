import 'package:flutter/material.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/ecc/api.dart';

import '../../utils/crypto/helper_crypto.dart';
import '../../utils/crypto/helper_crypto_ecdsa.dart';
import '../../utils/crypto/helper_crypto_rsa.dart';
import '../api_user/model/api_user_model_keys.dart';
import '../login_flow/login_flow_service.dart';
import 'keys_create_screen_controller.dart';
import 'keys_create_screen_presenter.dart';
import 'model/keys_create_screen_model.dart';

class KeysCreateScreenService extends ChangeNotifier {
  late final KeysCreateScreenPresenter presenter;
  late final KeysCreateScreenController controller;
  late final KeysCreateScreenModel model;
  final LoginFlowService loginFlowService;

  KeysCreateScreenService(this.loginFlowService) {
    presenter = KeysCreateScreenPresenter(this);
    controller = KeysCreateScreenController(this);
    model = KeysCreateScreenModel();
  }

  Future<void> genKeysWithTimer() async {
    await Future.wait([
      _genKeys().then((keys) {
        this.loginFlowService.model.user?.keys = keys;
      }),
      Future.delayed(Duration(seconds: 3))
    ]);
    this.loginFlowService.setKeysCreated();
  }

  Future<ApiUserModelKeys> _genKeys() async {
    ApiUserModelKeys keys = ApiUserModelKeys();

    AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> dataKey =
        await HelperCryptoRsa.createRSA();
    AsymmetricKeyPair<ECPublicKey, ECPrivateKey> signKey =
        await HelperCryptoEcdsa.createECDSA();

    keys.dataPublicKey = HelperCryptoRsa.encodeRSAPublic(dataKey.publicKey);
    keys.dataPrivateKey = HelperCryptoRsa.encodeRSAPrivate(dataKey.privateKey);

    keys.signPublicKey = HelperCryptoEcdsa.encodeECDSAPublic(signKey.publicKey);
    keys.signPrivateKey =
        HelperCryptoEcdsa.encodeECDSAPrivate(signKey.privateKey);

    keys.address = HelperCrypto.sha3(keys.signPublicKey!);

    return keys;
  }
}
