/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:sizer/sizer.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/keys_new_screen_save_bk.dart';
import 'widgets/keys_new_screen_save_bk_download.dart';
import 'widgets/keys_new_screen_save_continue.dart';
import 'widgets/keys_new_screen_save_restore.dart';

class KeysNewScreenSave extends StatelessWidget {
  static final double _marginBottomButton =
      5.h;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState state) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.95,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      child: Column(children: [
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 2.h),
                        child: Center(child: HelperImage("icon-alert"))),
                    Center(child: TikiTitle("Backup\nyour account")),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 2.h),
                        child: TikiSubtitle(
                          "We recommend you to securely save your key in case you change your device.",
                          fontSize: 2.h,
                          fontWeight: FontWeight.normal,
                        )),
                    Container(
                        child: Column(children: [
                      KeysNewScreenSaveBk(),
                      KeysNewScreenSaveBkDownload(),
                    ])),
                    KeysNewScreenSaveContinue(),
                  ]))
                ]),
                Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: _marginBottomButton),
                    child: KeysNewScreenSaveRestore())
              ]));
    });
  }
}
