/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/keys_screen/ui/keys/keys_new_screen/widgets/keys_new_screen_dialog_download/widgets/keys_new_screen_dialog_download_qr.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_title.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class KeysNewScreenSaveDialogDownload {
  static final double _marginTopTitle = 8.h;
  static final double _marginHorizontalTitle = 6.w;
  static final double _marginHorizontalSubtitle = 4.w;
  static final double _marginTopSubtitle = 1.h;
  static final double _marginVerticalButton = 4.h;
  static final double _marginTopQr = 3.h;

  AlertDialog alert(String keyData, GlobalKey repaintKey) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      titlePadding: EdgeInsets.only(
          top: _marginTopTitle,
          left: _marginHorizontalTitle,
          right: _marginHorizontalTitle),
      contentPadding: EdgeInsets.only(
          top: _marginTopSubtitle,
          left: _marginHorizontalSubtitle,
          right: _marginHorizontalSubtitle),
      title: _title(),
      content: _content(keyData, repaintKey),
    );
  }

  Widget _title() {
    return TikiTitle("Download key to your device", fontSize: 9);
  }

  Widget _content(String keyData, GlobalKey repaintKey) {
    return RepaintBoundary(
        key: repaintKey,
        child: Container(
            color: Colors.white,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'We recommend storing your QR key ',
                    style: _subtitleStyle(),
                    children: [
                      TextSpan(
                        text: 'off your phone',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      TextSpan(text: ', in case you lose it.'),
                    ]),
              ),
              Container(
                  margin: EdgeInsets.only(top: 1.h),
                  child: Text(
                      'Try not to store your keys on iCloud / Google Drive / Dropbox',
                      textAlign: TextAlign.center,
                      style: _subtitleStyle())),
              Container(
                  padding: EdgeInsets.only(top: _marginTopQr),
                  child: KeysNewScreenDialogDownloadQr(keyData)),
              Container(
                      padding:
                          EdgeInsets.symmetric(vertical: _marginVerticalButton),
                      child: TikiBigButton('DOWNLOAD', true, () => {})
              )


            ])));
  }

  TextStyle _subtitleStyle() {
    return TextStyle(
        fontFamily: 'NunitoSans',
        color: ConfigColor.emperor,
        fontWeight: FontWeight.w600,
        fontSize: 4.5.w);
  }
}
