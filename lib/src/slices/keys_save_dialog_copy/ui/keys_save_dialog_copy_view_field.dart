/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../keys_save_dialog_copy_service.dart';

class KeysSaveDialogCopyViewField extends StatelessWidget {
  final String? value;
  final bool isEmail;

  KeysSaveDialogCopyViewField({this.value, this.isEmail: false});

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<KeysSaveDialogCopyService>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ConfigColor.white,
          border: Border.all(color: ConfigColor.greyFour),
          borderRadius: BorderRadius.all(Radius.circular(2.w))),
      child: Row(children: [_text(), _button(context, service)]),
    );
  }

  Widget _text() {
    return Expanded(
        child: Container(
            padding: EdgeInsets.only(left: 2.w),
            child: Text(value!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left)));
  }

  Widget _button(BuildContext context, KeysSaveDialogCopyService service) {
    bool saved =
        isEmail ? service.model.isCopiedEmail : service.model.isCopiedKey;
    return Container(
        decoration: BoxDecoration(
            border: Border(left: BorderSide(color: ConfigColor.greyFour))),
        child: Container(
            decoration: BoxDecoration(
              color: ConfigColor.greyTwo,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(2.w),
                  bottomRight: Radius.circular(2.w)),
            ),
            child: TextButton(
                onPressed: () =>
                    service.controller.copyField(context, value!, isEmail),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.5.h),
                        child: Row(
                          children: [
                            Text("COPY",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                    color: saved
                                        ? ConfigColor.green
                                        : ConfigColor.tikiPurple)),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 1.w),
                                child: Container(
                                    width: 4.w,
                                    child: saved
                                        ? Image(
                                            image: AssetImage(
                                                "res/images/icon-check.png"))
                                        : Image(
                                            image: AssetImage(
                                                "res/images/icon-copy.png"))))
                          ],
                        ))))));
  }
}
