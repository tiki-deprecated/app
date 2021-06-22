/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widgets/keys_new_screen_save/keys_new_screen_save.dart';

class KeysNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TikiScaffold(
          foregroundChildren: [KeysNewScreenSave()],
          background: _background() as TikiBackground?,
        );
  }

  Widget _background() {
    return TikiBackground(
        backgroundColor: ConfigColor.serenade,
        topRight: HelperImage("keys-blob"));
  }
}
