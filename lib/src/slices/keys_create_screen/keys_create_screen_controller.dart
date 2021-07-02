import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/keys_restore_screen/keys_restore_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeysCreateScreenController {
  goToRestore(BuildContext context) {
    AppService appService = Provider.of<AppService>(context, listen: false);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => KeysRestoreScreenService(appService).getUI()));
  }
}
