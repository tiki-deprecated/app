/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../keys_save_dialog_dl_service.dart';

class KeysSaveDialogDlViewButton extends StatelessWidget {
  final GlobalKey repaintKey;

  KeysSaveDialogDlViewButton({required this.repaintKey});

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<KeysSaveDialogDlService>(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: _getColor(service)),
        child: Container(
            width: 67.w,
            child: Text(_getText(service),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ConfigColor.white,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.w800,
                  fontSize: 16.sp,
                  letterSpacing: 0.05.w,
                ))),
        onPressed: service.model.noPermission
            ? null
            : () => service.controller.downloadQR(context, repaintKey));
  }

  Color _getColor(KeysSaveDialogDlService service) {
    return service.model.isFailed || service.model.noPermission
        ? ConfigColor.tikiRed
        : ConfigColor.tikiPurple;
  }

  String _getText(KeysSaveDialogDlService service) {
    if (service.model.isFailed)
      return "TRY AGAIN";
    else if (service.model.noPermission)
      return "NO PERMISSION";
    else
      return "DOWNLOAD";
  }
}
