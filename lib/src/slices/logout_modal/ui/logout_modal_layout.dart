/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../logout_modal_service.dart';
import 'logout_modal_view_header.dart';

class LogoutModalLayout extends StatelessWidget {
  static const num _paddingVert = 2;

  @override
  Widget build(BuildContext context) {
    LogoutModalService service = Provider.of<LogoutModalService>(context);
    return Container(
      height: 35.h,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        LogoutModalViewHeader(),
        Padding(
          padding: EdgeInsets.only(top: 1.5*_paddingVert.h)),
        Expanded(
            child: Column(
              children: [
              Text("Are you sure you want to log out?",
                style: TextStyle(
                    color: ConfigColor.tikiBlue,
                    fontSize: 14.sp, fontWeight:
                FontWeight.w800)),
              Padding(
                    padding: EdgeInsets.only(top: _paddingVert.h)),
              TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size.fromWidth(80.w),
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.all(Radius.circular(3.w))),
                      side: BorderSide(
                        width: 2,
                        color: ConfigColor.orange
                      )
                    ),
                  child: Text("Log out", style: TextStyle(
                      color: ConfigColor.orange,
                      fontSize:14.sp,
                      fontWeight: FontWeight.bold)),
                  onPressed: () => service.controller.onLogout(context),
                ),
              Padding(
                    padding: EdgeInsets.only(top: 0.5*_paddingVert.h)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(80.w),
                  primary: ConfigColor.orange,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3.w))),
                ),
                child: Text("Cancel", style: TextStyle(
                    fontSize:14.sp,
                    fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(context).pop(),
              )
            ])
            )]));
  }
}
