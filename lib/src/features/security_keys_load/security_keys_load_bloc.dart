/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repositories/security_keys/security_keys_bloc.dart';
import 'package:app/src/repositories/security_keys/security_keys_model.dart';
import 'package:app/src/repositories/security_keys/security_keys_model_keypair.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/ecc/api.dart';

class SecurityKeysLoadBloc {
  final SecurityKeysBloc _securityKeysBloc;

  SecurityKeysLoadBloc(this._securityKeysBloc);

  Future<void> loadFromFile() async {
    /*FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path);
      var result2 = ScanResult.fromBuffer(file.readAsBytesSync());
      //String data = await QrCodeToolsPlugin.decodeFrom(file.path);
      print("done");
    }*/
  }

  Future<SecurityKeysModel> scan() async {
    ScanResult result = await BarcodeScanner.scan();
    if (result.type == ResultType.Barcode) {
      List<String> raw = result.rawContent.split(".");
      SecurityKeysModel securityKeysModel = _toModel(raw[0], raw[1], raw[2]);
      await _securityKeysBloc.write("mike@mytiki.com", securityKeysModel,
          overwrite: true);
      return securityKeysModel;
    }
    return null;
  }

  Future<SecurityKeysModel> manual(
      String id, String dataKey, String signKey) async {
    SecurityKeysModel securityKeysModel = _toModel(id, dataKey, signKey);
    await _securityKeysBloc.write("mike@mytiki.com", securityKeysModel,
        overwrite: true);
    return securityKeysModel;
  }

  SecurityKeysModel _toModel(String id, String dataKey, String signKey) {
    SecurityKeysModel securityKeysModel = SecurityKeysModel();
    securityKeysModel.dataKeys =
        SecurityKeysNewModelKeyPair<RSAPublicKey, RSAPrivateKey>();
    securityKeysModel.signKeys =
        SecurityKeysNewModelKeyPair<ECPublicKey, ECPrivateKey>();
    securityKeysModel.id = id;
    securityKeysModel.dataKeys.encodedPrivateKey = dataKey;
    securityKeysModel.signKeys.encodedPrivateKey = signKey;
    return securityKeysModel;
  }
}
