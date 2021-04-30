/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:app/src/features/keys/keys_new/keys_new_bloc.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeysNewScreenDownloadAddress extends StatelessWidget {
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewBloc, KeysNewState>(
      builder: (BuildContext context, KeysNewState state) {
        return Column(children: [
          Text(ConfigString.keysNew.downloadId,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.w600,
                  color: ConfigColor.orange)),
          Text(state.address,
              softWrap: true,
              style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.w600,
                  color: ConfigColor.orange))
        ]);
      },
    );
  }
}
