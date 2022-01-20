import '../../../config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../keys_modal_service.dart';

class KeysModalViewError extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context);
    String error = service.model.error ?? "An error occurred, please try again.";
    return Column(children: [
      Text(error),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(80.w),
          primary: ConfigColor.tikiPurple,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.w))),
        ),
        child: Text("Back",
            style:
            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        onPressed: () => service.controller.back(context),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(80.w),
          primary: ConfigColor.tikiPurple,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.w))),
        ),
        child: Text("Restart",
            style:
            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        onPressed: () => service.controller.restart(),
      )
    ]);
  }
}
