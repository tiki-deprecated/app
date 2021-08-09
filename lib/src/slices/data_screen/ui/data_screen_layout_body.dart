/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/data_screen/ui/data_screen_view_score.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:app/src/widgets/link_account/link_account.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'data_screen_view_soon.dart';

class DataScreenLayoutBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<DataScreenService>(context);
    var isLinked = service.model.googleAccount != null;
    return GestureDetector(
        child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    DataScreenViewScore(
                        image: isLinked ? "data-score-happy" : "data-score-sad",
                        summary:
                            isLinked ? "All good!" : "Uh-oh. No data just yet!",
                        description: isLinked
                            ? "Your account is linked now. See what data Gmail holds on you by tapping on the button below."
                            : "Get started by adding a Gmail account",
                        color: isLinked ? ConfigColor.green : ConfigColor.blue),
                    Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: LinkAccount(
                        username: service.model.googleAccount?.email,
                        type: "Gmail",
                        linkedIcon: "account-soon-gmail",
                        unlinkedIcon: "icon-link-gmail",
                        onLink: () => _showGoogleAlert(context, service),
                        //service.addGoogleAccount(),
                        onUnlink: () => service.removeGoogleAccount(),
                        onSee: () => service.controller.openGmailCards(context),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 2.h),
                        child: DataScreenViewSoon())
                  ],
                ))));
  }

  Future<void> _showGoogleAlert(
      BuildContext context, DataScreenService service) {
    var spacing = 2.4.h;
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: ConfigColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.5.h))),
        builder: (BuildContext context) => Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: spacing),
                  ),
                  Divider(
                    height: spacing,
                    thickness: 5,
                    color: ConfigColor.greyThree,
                    indent: 38.w,
                    endIndent: 38.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: spacing * 1.5),
                  ),
                  Center(
                      child: Text(
                    'Just so you know...',
                    style: TextStyle(
                        color: ConfigColor.tikiBlue,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: spacing * 1.5),
                  ),
                  HelperImage(
                    "gmail_alert",
                    height: 125,
                  ),
                  RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text:
                              "We’re patiently waiting for Google to put their\nstamp of approval on the TIKI app (a common\npractice called ",
                          style: TextStyle(
                            color: ConfigColor.tikiBlue,
                          ),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => service.openUrl(
                                      "https://support.google.com/cloud/answer/7454865?hl=en"),
                                text: 'OAuth API verification',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ConfigColor.tikiOrange)),
                            TextSpan(
                                text:
                                    ").\n\nThis adds a couple of extra steps to the process. Here’s what you need to do:")
                          ])),
                  Padding(
                    padding: EdgeInsets.only(top: spacing),
                  ),
                  Image.asset("res/images/gmail_alert.gif",
                      height: 270, width: 253),
                  Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromWidth(90.w),
                            primary: ConfigColor.orange,
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.w))),
                          ),
                          child: Text("OK, got it",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            service.addGoogleAccount();
                            Navigator.of(context).pop();
                          })),
                  Padding(
                    padding: EdgeInsets.only(top: spacing * 3),
                  ),
                ])));
  }
}
