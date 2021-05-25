/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_save/keys_new_screen_dialog/widgets/keys_new_screen_save_bk_download.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'keys_new_screen_dialog/widgets/keys_new_screen_save_bk.dart';
import 'keys_new_screen_dialog/widgets/keys_new_screen_save_continue.dart';
import 'keys_new_screen_dialog/widgets/keys_new_screen_save_restore.dart';

class KeysNewScreenSave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState state) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.95,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    2 * PlatformRelativeSize.blockVertical),
                            width: 10 * PlatformRelativeSize.blockVertical,
                            height: 10 * PlatformRelativeSize.blockVertical,
                            decoration: BoxDecoration(
                                border: Border.fromBorderSide(
                                    BorderSide(width: 2, color: Colors.red)),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    12 * PlatformRelativeSize.blockVertical))),
                            child: Center(
                                child: Text("!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Koara",
                                        color: Colors.red,
                                        fontSize: 6 *
                                            PlatformRelativeSize
                                                .blockVertical)))),
                        Center(child: TikiTitle("Backup\nyour account")),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    2 * PlatformRelativeSize.blockVertical),
                            child: TikiSubtitle(
                              "We recommend you to securely save your key in case you change your device.",
                              fontSize: 2 * PlatformRelativeSize.blockVertical,
                              fontWeight: FontWeight.normal,
                            )),
                        KeysNewScreenSaveBk(),
                        KeysNewScreenSaveBkDownload(),
                        KeysNewScreenSaveContinue(),
                      ],
                    ))
                  ],
                ),
                KeysNewScreenSaveRestore()
              ]));
    });
  }
}
