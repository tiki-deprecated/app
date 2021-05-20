/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen_dialog/keys_new_screen_save_dialog_copy_button.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_big_button.dart';
import 'package:app/src/widgets/components/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'keys_new_screen_save_continue.dart';
import 'keys_new_screen_save_restore.dart';

class KeysNewScreenSave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState state) {
      return Column(children: [
        Container(
            margin: EdgeInsets.symmetric(
                vertical: 2 * PlatformRelativeSize.blockVertical),
            width: 10 * PlatformRelativeSize.blockVertical,
            height: 10 * PlatformRelativeSize.blockVertical,
            decoration: BoxDecoration(
                border: Border.fromBorderSide(
                    BorderSide(width: 2, color: Colors.red)),
                borderRadius: BorderRadius.all(
                    Radius.circular(12 * PlatformRelativeSize.blockVertical))),
            child: Center(
                child: Text("!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Koara",
                        color: Colors.red,
                        fontSize: 6 * PlatformRelativeSize.blockVertical)))),
        Center(child: TikiTitle("Backup\nyour account")),
        Container(
            margin: EdgeInsets.symmetric(
                vertical: 2 * PlatformRelativeSize.blockVertical),
            child: TikiSubtitle(
              "We recommend you to securely save your key in case you change your device.",
              fontSize: 2 * PlatformRelativeSize.blockVertical,
              fontWeight: FontWeight.normal,
            )),
        GestureDetector(
            child: Stack(clipBehavior: Clip.none, children: [
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: HelperImage("lock-icon")),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Save securely",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 3 *
                                          PlatformRelativeSize.blockVertical,
                                      color: ConfigColor.mardiGras)),
                              Text("(recommended)",
                                  style: TextStyle(
                                      fontSize: 3 *
                                          PlatformRelativeSize.blockVertical,
                                      color: ConfigColor.jade)),
                            ])
                      ])),
              Positioned(
                  top: -30.0, right: -30.0, child: HelperImage("green-check")),
            ]),
            onTap: () => _saveKey(context, state)),
        GestureDetector(
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(Icons.download,
                                size: 4 * PlatformRelativeSize.blockVertical)),
                        Text("Download",
                            style: TextStyle(
                                fontSize:
                                    2 * PlatformRelativeSize.blockVertical,
                                color: ConfigColor.mardiGras)),
                      ])),
              Positioned(
                  top: -30.0, right: -30.0, child: HelperImage("green-check")),
            ]),
            onTap: _downloadQr),
        KeysNewScreenSaveContinue(),
        KeysNewScreenSaveRestore()
      ]);
    });
  }

  _saveKey(BuildContext context, KeysNewScreenState state) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: TikiTitle("Save securely to a pass manager", fontSize: 9),
              content: Container(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                TikiSubtitle(
                  'Press submit to save your key to your default pass manager or copy/paste your details manually.',
                  fontWeight: FontWeight.normal,
                  fontSize: 4.5 * PlatformRelativeSize.blockHorizontal,
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                Container(
                    child: Column(children: [
                  Text(
                    'YOUR ACCOUNT E-MAIL AND KEY',
                    style: TextStyle(color: Colors.grey),
                  ),
                  // TODO KeysNewScreenSaveCopyButton(_email, helperLogIn.current.email),
                  KeysNewScreenSaveCopyButton(
                      "DATA KEY",
                      state.address! +
                          '.' +
                          state.dataPrivate! +
                          '.' +
                          state.signPrivate!),
                ])),
                Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                TikiBigButton('Continue', true, () => {})
              ])));
        });
  }

  void _downloadQr() {}
}
