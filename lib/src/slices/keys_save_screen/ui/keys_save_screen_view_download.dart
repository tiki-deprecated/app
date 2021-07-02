/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/keys/keys_service.dart';
import 'package:app/src/slices/keys_save_dialog_download/keys_save_dialog_dl_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../keys_save_screen_service.dart';

class KeysNewScreenSaveBkDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var keysSaveScreenService = Provider.of<KeysSaveScreenService>(context);
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Stack(clipBehavior: Clip.none, children: [
              Container(
                  padding: EdgeInsets.all(4.w),
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: HelperImage("icon-download")),
                        Text("Download",
                            style: TextStyle(
                                fontSize: 2.5.h,
                                fontWeight: FontWeight.bold,
                                color: ConfigColor.mardiGras)),
                      ])),
              keysSaveScreenService.model.downloaded
                  ? Positioned(
                      top: 0,
                      left: 5.w,
                      child: Container(
                          height: 5.h, child: HelperImage("green-check")))
                  : Container(),
            ])),
        onTap: () => onPressed(context, keysSaveScreenService));
  }

  void onPressed(
      BuildContext context, KeysSaveScreenService keysSaveScreenService) async {
    GlobalKey repaintKey = new GlobalKey();
    var appService = Provider.of<AppService>(context, listen: false);
    var keys = await KeysService().getKeys(appService.model.user!.address!);
    var key =
        keys.address! + '.' + keys.dataPrivateKey! + '.' + keys.signPrivateKey!;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return KeysSaveDialogDlService(
                  keysSaveScreenService: keysSaveScreenService,
                  combinedKey: key,
                  repaintKey: repaintKey)
              .getUI();
        });
  }
}