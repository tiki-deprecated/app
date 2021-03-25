/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_model.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/platform_wrapper.dart';

class UISecurityRestoreBloc {
  final HelperSecurityKeysBloc _helperSecurityKeysBloc;

  UISecurityRestoreBloc(this._helperSecurityKeysBloc);

  Future<void> loadFromFile() async {
    /*FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path);
      var result2 = ScanResult.fromBuffer(file.readAsBytesSync());
      //String data = await QrCodeToolsPlugin.decodeFrom(file.path);
      print("done");
    }*/
  }

  Future<HelperSecurityKeysModel> scan() async {
    ScanResult result = await BarcodeScanner.scan();
    if (result.type == ResultType.Barcode) {
      List<String> raw = result.rawContent.split(".");
      HelperSecurityKeysModel keys = _toModel(raw[0], raw[1], raw[2]);
      await _helperSecurityKeysBloc.save(keys);
      return keys;
    }
    return null;
  }

  Future<HelperSecurityKeysModel> manual(
      String id, String dataKey, String signKey) async {
    HelperSecurityKeysModel keys = _toModel(id, dataKey, signKey);
    await _helperSecurityKeysBloc.save(keys);
    return keys;
  }

  HelperSecurityKeysModel _toModel(String id, String dataKey, String signKey) {
    HelperSecurityKeysModel securityKeysModel = HelperSecurityKeysModel();
    securityKeysModel.address = id;
    securityKeysModel.dataKey.encodedPrivate = dataKey;
    securityKeysModel.signKey.encodedPrivate = signKey;
    return securityKeysModel;
  }
}
