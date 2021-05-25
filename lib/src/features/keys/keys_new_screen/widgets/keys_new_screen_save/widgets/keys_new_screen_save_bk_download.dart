/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_dialog_download/bloc/keys_new_screen_dialog_download_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_dialog_download/keys_new_screen_dialog_download.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeysNewScreenSaveBkDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => KeysNewScreenDialogDownloadBloc(),
        child: BlocConsumer<KeysNewScreenDialogDownloadBloc,
                KeysNewScreenDialogDownloadState>(
            listener:
                (BuildContext context, KeysNewScreenDialogDownloadState state) {
          if (state is KeysNewScreenDialogDownloadSuccess)
            BlocProvider.of<KeysNewScreenBloc>(context)
                .add(KeysNewScreenBackedUp());
        }, builder:
                (BuildContext context, KeysNewScreenDialogDownloadState state) {
          return _button(context, state);
        }));
  }

  _button(context, state) {
    return GestureDetector(
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
              margin: EdgeInsets.only(bottom: 40),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: ConfigColor.gallery,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: ConfigColor.alto),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: Offset(6, 6), // changes position of shadow
                    ),
                  ]),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: HelperImage("icon-download")),
                Text("Download",
                    style: TextStyle(
                        fontSize: 2.5 * PlatformRelativeSize.blockVertical,
                        fontWeight: FontWeight.bold,
                        color: ConfigColor.mardiGras)),
              ])),
          state is KeysNewScreenDialogDownloaded
              ? Positioned(
                  top: -30.0, right: -30.0, child: HelperImage("green-check"))
              : Container(),
        ]),
        onTap: () => onPressed(context));
  }

  void onPressed(BuildContext context) async {
    GlobalKey repaintKey = new GlobalKey();
    KeysNewScreenState state =
        BlocProvider.of<KeysNewScreenBloc>(context).state;
    KeysNewScreenDialogDownloadBloc bloc =
        BlocProvider.of<KeysNewScreenDialogDownloadBloc>(context);
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          String keyData = state.address! +
              "." +
              state.dataPrivate! +
              "." +
              state.signPrivate!;
          return KeysNewScreenSaveDialogDownload()
              .alert(keyData, bloc, repaintKey);
        });
  }
}
