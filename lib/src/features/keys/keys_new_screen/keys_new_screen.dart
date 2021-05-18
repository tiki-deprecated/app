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
import 'package:app/src/utils/platform/platform_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

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
        MultiBlocProvider(providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  KeysNewScreenBloc.provide(context)),
          BlocProvider(
              create: (BuildContext context) => KeysNewScreenDownloadBloc())
        ], child: _foreground())
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

  // TODO check if is new user and call
  // TikiAnalytics.getLogger().regenerateDeviceId();
  Widget _foreground() {
    return BlocConsumer<KeysNewScreenBloc, KeysNewScreenState>(
      listener: (BuildContext context, KeysNewScreenState screenState) {
        if (screenState is KeysNewScreenSuccess)
          TikiAnalytics.getLogger().logEvent('KEYS_CREATED');
        Navigator.of(context).pushNamedAndRemoveUntil(
            ConfigNavigate.path.home, (route) => false);
      },
      builder: (BuildContext context, KeysNewScreenState screenState) {
        if (screenState is KeysNewScreenInitial) {
          TikiAnalytics.getLogger().logEvent('CREATE_KEYS');
          return KeysNewScreenGen();
        } else {
          return BlocConsumer<KeysNewScreenDownloadBloc,
                  KeysNewScreenDownloadState>(
              listener: (BuildContext context,
                      KeysNewScreenDownloadState downloadState) =>
                  downloadStateListener(context, downloadState),
              builder: (BuildContext context,
                  KeysNewScreenDownloadState downloadState) {
                if (downloadState is KeysNewScreenDownloadInProgress){
                  TikiAnalytics.getLogger().logEvent('DOWNLOAD_KEYS');
                  return KeysNewScreenDownload();
                }else {
                  TikiAnalytics.getLogger().logEvent('SAVE_KEYS');
                  return KeysNewScreenSave();
                }
              });
        }
      },
    );
  }

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
}
