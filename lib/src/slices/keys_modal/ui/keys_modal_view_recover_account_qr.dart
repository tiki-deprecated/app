import '../../../config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import '../keys_modal_service.dart';

class KeysModalViewRecoverAccountQr extends StatelessWidget {
  final String _text = "I have a QR code";

  @override
  Widget build(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromWidth(80.w),
        primary: ConfigColor.tikiPurple,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.w))),
      ),
      child: Text(_text,
          style:
          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
      onPressed: () => service.controller.scanQrCode()
    );
  }
}