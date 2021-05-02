/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/widgets.dart';

import '../keys_new_screen_gen/keys_new_screen_gen_restore.dart';
import 'keys_new_screen_save_bk_copy.dart';
import 'keys_new_screen_save_bk_download.dart';
import 'keys_new_screen_save_bk_qr.dart';
import 'keys_new_screen_save_bk_send.dart';
import 'keys_new_screen_save_continue.dart';
import 'keys_new_screen_save_skip.dart';
import 'keys_new_screen_save_subtitle.dart';
import 'keys_new_screen_save_title.dart';

class KeysNewScreenSave extends StatelessWidget {
  static final double _marginTopTitle = 15 * PlatformRelativeSize.blockVertical;
  static final double _marginTopSubtitle =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginBottomButton =
      5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopDownload =
      3 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalSkip =
      1 * PlatformRelativeSize.blockVertical;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: PlatformRelativeSize.marginHorizontal2x),
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(top: _marginTopTitle),
                    alignment: Alignment.center,
                    child: KeysNewScreenSaveTitle()),
                Container(
                    margin: EdgeInsets.only(top: _marginTopSubtitle),
                    alignment: Alignment.center,
                    child: KeysNewScreenSaveSubtitle()),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: KeysNewScreenSaveBkCopy()),
                      Container(
                          margin: EdgeInsets.only(
                              top: 2 * PlatformRelativeSize.blockVertical),
                          alignment: Alignment.centerLeft,
                          child: KeysNewScreenSaveBkDownload()),
                      Container(
                          margin: EdgeInsets.only(
                              top: 2 * PlatformRelativeSize.blockVertical),
                          alignment: Alignment.centerLeft,
                          child: KeysNewScreenSaveBkSend()),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                              top: 2 * PlatformRelativeSize.blockVertical),
                          child: KeysNewScreenSaveBkQr())
                    ])),
                Container(
                    margin: EdgeInsets.only(top: _marginTopDownload),
                    child: KeysNewScreenSaveContinue()),
                Container(
                    margin: EdgeInsets.symmetric(vertical: _marginVerticalSkip),
                    child: KeysNewScreenSaveSkip()),
                Container(
                    margin: EdgeInsets.only(bottom: _marginBottomButton),
                    child: KeysNewScreenGenRestore())
              ])))
    ]);
  }
}
