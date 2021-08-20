import 'package:flutter/material.dart';

import '../keys_restore_screen/keys_restore_screen_service.dart';
import 'keys_create_screen_service.dart';

class KeysCreateScreenController {
  final KeysCreateScreenService service;

  KeysCreateScreenController(this.service);

  goToRestore(BuildContext context) => Navigator.of(context).push(
      KeysRestoreScreenService(service.loginFlowService)
          .presenter
          .createRoute(context));
}
