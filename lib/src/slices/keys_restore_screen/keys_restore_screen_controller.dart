/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper_permission.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import 'keys_restore_screen_service.dart';

class KeysRestoreScreenController {
  final KeysRestoreScreenService service;

  KeysRestoreScreenController(this.service);

  void back(BuildContext context) => Navigator.of(context).pop();

  void updateKeys(String key) => service.updateCombinedKeys(key);

  void scan() async {
    if (await HelperPermission.request(Permission.camera)) {
      ScanResult result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        updateKeys(result.rawContent);
        if (service.canSubmit()) service.saveAndLogin();
      }
    }
  }

  void manualSubmit() async {
    if (service.canSubmit()) await service.saveAndLogin();
  }
}
