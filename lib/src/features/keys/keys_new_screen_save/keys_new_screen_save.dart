/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'keys_new_screen_save_continue.dart';
import 'keys_new_screen_save_restore.dart';

class KeysNewScreenSave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      Center(child: TikiTitle("Backup \n your account")),
      Container(
          margin: EdgeInsets.symmetric(
              vertical: 2 * PlatformRelativeSize.blockVertical),
          child: TikiSubtitle(
            "We recommend you to securely save your key in case you change your device.",
            fontSize: 2 * PlatformRelativeSize.blockVertical,
            fontWeight: FontWeight.normal,
          )),
      GestureDetector(
        child:Stack(clipBehavior: Clip.none, children: [
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
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: HelperImage("lock-icon")),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Save securely",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 3 * PlatformRelativeSize.blockVertical,
                        color: ConfigColor.mardiGras)),
                Text("(recommended)",
                    style: TextStyle(
                        fontSize: 3 * PlatformRelativeSize.blockVertical,
                        color: ConfigColor.jade)),
              ])
            ])),
        Positioned(top: -30.0, right: -30.0, child: HelperImage("green-check")),
      ]), onTap: _saveSecurely,),
    GestureDetector(
    child:Stack(clipBehavior: Clip.none, children: [
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
                  child: Icon(Icons.download,
                      size: 4 * PlatformRelativeSize.blockVertical)),
              Text("Download",
                  style: TextStyle(
                      fontSize: 2 * PlatformRelativeSize.blockVertical,
                      color: ConfigColor.mardiGras)),
            ])),
        Positioned(top: -30.0, right: -30.0, child: HelperImage("green-check")),
      ]), onTap: _downloadQr),
      KeysNewScreenSaveContinue(),
      KeysNewScreenSaveRestore()
    ]); //); //);
  }

  void _saveSecurely(){}

  void _downloadQr() {
  }
}
