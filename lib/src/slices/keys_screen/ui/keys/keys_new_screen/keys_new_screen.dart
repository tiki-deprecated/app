/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_gen/keys_new_screen_gen.dart';
import 'package:app/src/utils/analytics/analytics_repository.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/keys_new_screen_save/keys_new_screen_save.dart';

class KeysNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => KeysNewScreenBloc.provide(context),
        child: TikiScaffold(
          foregroundChildren: [_blocConsumer()],
          background: _background() as TikiBackground?,
        ));
  }

  Widget _blocConsumer() {
    return BlocConsumer<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState screenState) {
      if (screenState is KeysNewScreenInitial) {
        TikiAnalytics.getLogger()!.logEvent('CREATE_KEYS');
        return KeysNewScreenGen();
      } else {
        TikiAnalytics.getLogger()!.logEvent('SAVE_KEYS');
        return KeysNewScreenSave();
      }
    }, listener: (BuildContext context, KeysNewScreenState screenState) {
      if (screenState is KeysNewScreenSuccess) {
        TikiAnalytics.getLogger()!.logEvent('KEYS_CREATED');
        Navigator.of(context).pushNamedAndRemoveUntil(
            ConfigNavigate.path.home, (route) => false);
      }
    });
  }

  Widget _background() {
    return TikiBackground(
        backgroundColor: ConfigColor.serenade,
        topRight: HelperImage("keys-blob"));
  }
}
