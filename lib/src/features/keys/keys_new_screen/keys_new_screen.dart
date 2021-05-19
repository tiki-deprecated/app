/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/keys/keys_new_screen/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen_dialog/keys_new_screen_save_dialog_download.dart';
import 'package:app/src/features/keys/keys_new_screen_download/keys_new_screen_download.dart';
import 'package:app/src/features/keys/keys_new_screen_download/keys_new_screen_download_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen_gen/keys_new_screen_gen.dart';
import 'package:app/src/features/keys/keys_new_screen_save/keys_new_screen_save.dart';
import 'package:app/src/utils/analytics/tiki_analytics.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

class KeysNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  KeysNewScreenBloc.provide(context)),
          BlocProvider(
              create: (BuildContext context) => KeysNewScreenDownloadBloc())
        ],
        child: TikiScaffold(
          foregroundChildren: [keysCreationBlocConsumer()],
          background: _background() as TikiBackground?,
        ));
  }

  /// The [BlocConsumer] for keys creation
  ///
  /// It listens to [KeysNewScreenState] and creates the initial interface.
  Widget keysCreationBlocConsumer() {
    return BlocConsumer<KeysNewScreenBloc, KeysNewScreenState>(
        listener: keysCreationListener, builder: keysCreationBuilder);
  }

  /// The listener for keys creation
  void keysCreationListener(
      BuildContext context, KeysNewScreenState screenState) {
    if (screenState is KeysNewScreenSuccess) {
      TikiAnalytics.getLogger()!.logEvent('KEYS_CREATED');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(ConfigNavigate.path.home, (route) => false);
    }
  }

  /// The [Builder] for keys creation.
  Widget keysCreationBuilder(
      BuildContext context, KeysNewScreenState screenState) {
    if (screenState is KeysNewScreenInitial) {
      TikiAnalytics.getLogger()!.logEvent('CREATE_KEYS');
      return KeysNewScreenGen();
    } else {
      return BlocConsumer<KeysNewScreenDownloadBloc,
              KeysNewScreenDownloadState>(
          listener: downloadStateListener, builder: downloadBuilder);
    }
  }

  /// The [Builder] for keys download
  Widget downloadBuilder(
      BuildContext context, KeysNewScreenDownloadState downloadState) {
    if (downloadState is KeysNewScreenDownloadInProgress) {
      TikiAnalytics.getLogger()!.logEvent('DOWNLOAD_KEYS');
      return KeysNewScreenDownload();
    } else {
      TikiAnalytics.getLogger()!.logEvent('SAVE_KEYS');
      return KeysNewScreenSave();
    }
  }

  /// The listener for keys daonload
  void downloadStateListener(
      BuildContext context, KeysNewScreenDownloadState downloadState) {
    if (downloadState is KeysNewScreenDownloadSuccess) {
      if (downloadState.shouldShare)
        Share.shareFiles([downloadState.path]);
      else
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return KeysNewScreenSaveDialogDownload(downloadState.path);
          },
        );
    }
  }

  Widget _background() {
    return TikiBackground(
        backgroundColor: ConfigColor.serenade,
        topRight: HelperImage("keys-blob"));
  }
}
