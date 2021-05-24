/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeysNewScreenSaveSkip extends StatelessWidget {
  static const String _text = "SKIP SAVING";
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          BlocProvider.of<KeysNewScreenBloc>(context)
              .add(KeysNewScreenSkipped());
        },
        child: Text(_text,
            style: TextStyle(
                color: ConfigColor.boulder,
                fontWeight: FontWeight.bold,
                fontSize: _fontSize)));
  }
}
