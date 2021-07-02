import 'package:app/src/slices/keys_create_screen/keys_create_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeysCreateScreenController {
  restoreKeys(BuildContext context) {
    Provider.of<KeysCreateScreenService>(context).restoreKeys(context);
  }
}
