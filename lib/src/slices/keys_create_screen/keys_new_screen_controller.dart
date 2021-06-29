import 'package:app/src/slices/keys_create_screen/keys_new_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeysNewScreenController {
  restoreKeys(BuildContext context) {
    Provider.of<KeysNewScreenService>(context).restoreKeys(context);
  }
}
