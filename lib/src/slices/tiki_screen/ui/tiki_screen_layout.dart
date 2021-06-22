/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_add_email_button.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_card_community.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_card_follow_us.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_card_news.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_card_release.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_counter.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_logout.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_refer.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_share.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_title.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';


class TikiScreenLayout extends StatelessWidget {
  static final double _marginVerticalShare = 6.h;
  static final double _marginTopCards = 2.h;
  static final double _marginVerticalLogOut = 4.h;

  Widget _background(context) {
    return TikiBackground(
      backgroundColor: Color(0XFFF4F4F4),
      topRight: HelperImage(
        "home-locker-tr",
        width: MediaQuery.of(context).size.width * 3 / 5,
      ),
    );
  }

  List<Widget> _foreground(BuildContext context) {
    return [
      Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 140, bottom: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child: TikiScreenViewTitle("Get started"))
              ])),
      Container(child: AddGmailButton()),
      Container(
          width: double.maxFinite,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                margin: EdgeInsets.only(top: 50, bottom: 20),
                child: TikiScreenViewTitle("TIKI updates"))
          ])),
      Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            //boxShadow: [BoxShadow(offset: Offset(4,4), blurRadius: 20, color:Color(0x33000000))]
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 24),
                    child: TikiScreenViewCounter(),
                    ),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: TikiScreenViewRefer()),
                Container(
                    margin:
                        EdgeInsets.symmetric(vertical: _marginVerticalShare),
                    alignment: Alignment.topCenter,
                    child: TikiScreenViewShare()),
              ])),
      Container(
        margin: EdgeInsets.only(top: _marginTopCards),
        alignment: Alignment.topCenter,
        child: TikiNextReleaseCard(),
      ),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiNewsCard()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiCommunityCard()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiFollowUsCard()),
      Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(vertical: _marginVerticalLogOut),
          child: TikiScreenViewLogout()),
      Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.symmetric(vertical: _marginVerticalLogOut),
        child: Text("v0.1.1", style: TextStyle(color: Colors.grey)),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TikiScaffold(
        foregroundChildren: _foreground(context),
        background: _background(context) as TikiBackground?);
  }
}
