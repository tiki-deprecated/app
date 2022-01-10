/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/helper_image.dart';
import '../keys_save_screen_service.dart';
import 'keys_save_screen_view_backup.dart';
import 'keys_save_screen_view_continue.dart';
import 'keys_save_screen_view_download.dart';
import 'keys_save_screen_view_download_link.dart';
import 'keys_save_screen_view_restore.dart';
import 'keys_save_screen_view_subtitle.dart';
import 'keys_save_screen_view_title.dart';

class KeysNewScreenLayoutForeground extends StatelessWidget {
  static final double _marginBottomButton = 4.h;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<KeysSaveScreenService>(context);
    return Container(
        height: MediaQuery.of(context).size.height * 0.95,
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Center(child: HelperImage("icon-alert"))),
          Container(
              margin: EdgeInsets.only(top: 2.h),
              child: KeysNewScreenViewTitle()),
          Container(
              margin: EdgeInsets.only(top: 2.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: KeysNewScreenViewSubtitle()),
          Container(
              margin: EdgeInsets.only(top: 2.h), child: KeysNewScreenSaveBk()),
          Container(
              margin: EdgeInsets.only(top: 2.h),
              child: KeysNewScreenSaveBkDownload()),
          if (service.model.downloaded)
            Container(
                margin: EdgeInsets.only(top: 1.h, left: 5.w, right: 5.w),
                child: KeysSaveScreenViewDownloadLink()),
          Container(
              margin: EdgeInsets.only(top: 6.h),
              child: KeysNewScreenSaveContinue()),
          Expanded(
              child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: _marginBottomButton),
                  child: KeysNewScreenSaveRestore()))
        ]));
  }
}
