import '../../../config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import '../keys_modal_service.dart';

class KeysModalViewNewAccountRecover extends StatelessWidget {
  final String _text = "I already have an account";

  @override
  Widget build(BuildContext context) {
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
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}