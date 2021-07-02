import 'package:app/src/slices/keys_restore_screen/keys_restore_screen_service.dart';
import 'package:flutter/material.dart';

class KeysCreateScreenController {
  goToRestore(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => KeysRestoreScreenService().getUI()));
  }
}
