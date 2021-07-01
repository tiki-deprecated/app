/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/keys/keys_service.dart';
import 'package:app/src/slices/keys_save_dialog_copy/keys_save_dialog_copy_service.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class KeysNewScreenSaveBk extends StatelessWidget {
  KeysNewScreenSaveBk();

  @override
  Widget build(BuildContext context) {
    var isSaved = false;
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Stack(clipBehavior: Clip.none, children: [
              Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 0.5.h, right: 4.w),
                            child: HelperImage("lock-icon")),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Save securely",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 3.h,
                                      color: ConfigColor.mardiGras)),
                              Text("(recommended)",
                                  style: TextStyle(
                                      fontSize: 3.h,
                                      fontWeight: FontWeight.bold,
                                      color: ConfigColor.jade)),
                            ])
                      ])),
              isSaved
                  ? Positioned(
                      top: 0.25.h,
                      left: 6.w,
                      child: Container(
                          height: 5.h, child: HelperImage("green-check")))
                  : Container(),
            ])),
        onTap: () => _saveKey(context));
  }

  _saveKey(BuildContext context) async {
    var appService = Provider.of<AppService>(context, listen: false);
    var keysSaveScreenService =
        Provider.of<KeysSaveScreenService>(context, listen: false);
    var current = appService.authService.current;
    var keysService = KeysService();
    var keys = await keysService.getKeys(appService.model.user!.address!);
    var key =
        keys.address! + '.' + keys.dataPrivateKey! + '.' + keys.signPrivateKey!;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) =>
            KeysSaveDialogCopyService(combinedKey: key, email: current.email!)
                .getUI());
  }
}
