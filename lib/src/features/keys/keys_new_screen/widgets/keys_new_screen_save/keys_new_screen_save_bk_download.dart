/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_download/bloc/keys_new_screen_download_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_save/keys_new_screen_dialog/widgets/download/keys_new_screen_save_dialog_download.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/helper/helper_permission.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class KeysNewScreenSaveBkDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState state) {
      return _button(context, state);
    });
  }

  _button(context, state) {
    return GestureDetector(
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
              margin: EdgeInsets.only(bottom: 40),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(3, 3), // changes position of shadow
                    ),
                  ]),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.download_rounded,
                        size: 4 * PlatformRelativeSize.blockVertical)),
                Text("Download",
                    style: TextStyle(
                        fontSize: 2 * PlatformRelativeSize.blockVertical,
                        color: ConfigColor.mardiGras)),
              ])),
          Positioned(
              top: -30.0, right: -30.0, child: HelperImage("green-check")),
        ]),
        onTap: () => onPressed(context, state));
  }

  void onPressed(BuildContext context, KeysNewScreenState state) async {
    String keyData = state.address! +
        "." +
        state.dataPrivate! +
        "." +
        state.signPrivate!;
    KeysNewScreenDownloadBloc bloc =
    BlocProvider.of<KeysNewScreenDownloadBloc>(context);
    GlobalKey repaintKey = new GlobalKey();
    bloc.add(KeysNewScreenDownloadRendered(repaintKey, bloc.state.shouldShare));

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
          KeysNewScreenSaveDialogDownload(keyData, repaintKey: repaintKey).alert(context)
    );
  }
}
