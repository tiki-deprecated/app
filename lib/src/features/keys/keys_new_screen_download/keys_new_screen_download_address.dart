/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/keys_new_screen_bloc.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeysNewScreenDownloadAddress extends StatelessWidget {
  static const String _text = "TIKI ID: ";
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
      builder: (BuildContext context, KeysNewScreenState state) {
        return Text(_text + state.address,
            softWrap: true,
            style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.w600,
                color: ConfigColor.orange));
      },
    );
  }
}
