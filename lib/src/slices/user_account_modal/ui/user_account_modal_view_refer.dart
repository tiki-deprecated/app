import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/user_account_modal/user_account_modal_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'user_account_modal_view_refer_count.dart';
import 'user_account_modal_view_refer_share.dart';

class UserAccountModalViewRefer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserAccountModalService userAccountModalService =
        Provider.of<UserAccountModalService>(context);
    return Container(
        decoration: BoxDecoration(
          color: ConfigColor.greyTwo,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: UserAccountModalViewReferCount(),
              ),
              Container(
                  margin: EdgeInsets.only(top: 3.5.h),
                  child: userAccountModalService.referralService.presenter
                      .render()),
              Container(
                  margin: EdgeInsets.only(
                      top: 4.5.h, bottom: 5.5.h, left: 13.w, right: 13.w),
                  alignment: Alignment.topCenter,
                  child: UserAccountModalViewReferShare()),
            ]));
  }
}
