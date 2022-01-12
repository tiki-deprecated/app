/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_create_screen/keys_create_screen_service.dart';
import 'package:app/src/slices/keys_modal/keys_modal_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'keys_create_screen_layout_background.dart';
import 'keys_create_screen_layout_foreground.dart';

class KeysCreateScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KeysCreateScreenService service = Provider.of<KeysCreateScreenService>(context);
    KeysModalService(service).presenter.showModal(context);
    return Scaffold(
        body: Center(
            child: Stack(children: [
      KeysCreateScreenLayoutBackground(),
      KeysCreateScreenLayoutForeground()
    ])));
  }
}
