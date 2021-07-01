/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/keys/keys_service.dart';
import 'package:app/src/slices/keys_save_dialog/keys_new_screen_dialog_download.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../keys_save_screen_service.dart';

class KeysNewScreenSaveBkDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Provider.of<KeysSaveScreenService>(context).model.downloaded
                  ? Positioned(
                      top: 0,
                      left: 5.w,
                      child: Container(
                          height: 5.h, child: HelperImage("green-check")))
                  : Container(),
            ])),
        onTap: () => onPressed(context));
  }

  void onPressed(BuildContext context) async {
    GlobalKey repaintKey = new GlobalKey();
    var appService = Provider.of<AppService>(context, listen: false);
    var keysSaveScreenService =
        Provider.of<KeysSaveScreenService>(context, listen: false);
    var keysService = KeysService();
    var keys = await keysService.getKeys(appService.model.user!.address!);
    var key =
        keys.address! + '.' + keys.dataPrivateKey! + '.' + keys.signPrivateKey!;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return KeysNewScreenSaveDialogDownload()
              .alert(key, repaintKey, keysSaveScreenService);
        });
  }
}
