/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper_permission.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'keys_restore_screen_service.dart';

class KeysRestoreScreenController {
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void scan(BuildContext context) async {
    if (await HelperPermission.request(Permission.camera)) {
      ScanResult result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        Provider.of<KeysRestoreScreenService>(context, listen: false)
            .saveAndLogin(result.rawContent, context);
      }
    }
  }

  void manualSubmit(BuildContext context) async {
    var service = Provider.of<KeysRestoreScreenService>(context, listen: false);
    if (service.canSubmit()) {
      Provider.of<KeysRestoreScreenService>(context, listen: false)
          .saveAndLogin(service.model.manualKeys!, context);
    }
  }
}
