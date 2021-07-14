import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'keys_create_screen_service.dart';
import 'ui/keys_create_screen_layout.dart';

class KeysCreateScreenPresenter extends Page {
  final KeysCreateScreenService service;

  KeysCreateScreenPresenter(this.service)
      : super(key: ValueKey("KeysCreateScreen"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: service, child: KeysCreateScreenLayout()));
  }
}
