import '../user_account_modal_service.dart';
import 'package:provider/provider.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserAccountModalViewSupport extends StatelessWidget {
  static const String _title = "Need help?";

  @override
  Widget build(BuildContext context) {
    UserAccountModalService service = Provider.of<UserAccountModalService>(context);
    return GestureDetector(
        onTap: () => service.controller.goToSupport(context),
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal:1.5.h),
        decoration: BoxDecoration(
          color: ConfigColor.greyTwo,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              HelperImage("helper-icon", width: 4.5.h),
              Padding(padding: EdgeInsets.only(right: 2.w)),
              Expanded( child: Text( _title,
                      style: TextStyle(fontSize: 12.sp,
                      fontWeight: FontWeight.bold))
              ),
              HelperImage("icon-forward", width: 4.5.h)
            ])));
  }
}