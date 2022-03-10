/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:permission_handler/permission_handler.dart';

class HelperPermission {
  static Future<bool> request(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      PermissionStatus result = await permission.request();
      if (result.isGranted) return true;
    }
    return false;
  }
}
