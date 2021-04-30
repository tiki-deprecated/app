/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new/keys_new_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen_download/keys_new_screen_download.dart';
import 'package:app/src/features/keys/keys_new_screen_gen/keys_new_screen_gen.dart';
import 'package:app/src/features/keys/keys_new_screen_save/keys_new_screen_save.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeysNewScreen extends PlatformScaffold {
  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: _screen(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _screen(context));
  }

  Widget _screen(BuildContext context) {
    return Stack(
      children: [
        _background(),
        BlocProvider(
            create: (BuildContext context) => KeysNewBloc.provide(context),
            child: BlocBuilder<KeysNewBloc, KeysNewState>(
              builder: (BuildContext context, KeysNewState state) {
                if (state is KeysNewInitial)
                  return KeysNewScreenGen();
                else if (state is KeysNewDownloadInProgress)
                  return KeysNewScreenDownload();
                else
                  return KeysNewScreenSave();
              },
            ))
      ],
    );
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConfigColor.serenade,
        ),
        Container(
            alignment: Alignment.topRight, child: HelperImage("keys-blob")),
      ],
    );
  }
}
