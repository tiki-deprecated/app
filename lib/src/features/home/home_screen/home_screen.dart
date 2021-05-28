/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/home/home_counter/bloc/home_counter_cubit.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_counter.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_refer.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_share.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_title.dart';
import 'package:app/src/features/home/home_screen/widgets/tiki_community_card.dart';
import 'package:app/src/features/home/home_screen/widgets/tiki_follow_us_card.dart';
import 'package:app/src/features/home/home_screen/widgets/tiki_news_card.dart';
import 'package:app/src/features/home/home_screen/widgets/tiki_release_card.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_text_button.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/home_screen_logout.dart';

class HomeScreen extends StatelessWidget {
  static final double _marginTopTitle = 5.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCount = 4 * PlatformRelativeSize.blockVertical;
  static final double _marginTopRefer = 8 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalShare =
      6 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCards = 2 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalLogOut =
      4 * PlatformRelativeSize.blockVertical;

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                child: HomeScreenTitle("Get started"))
          ])),
      Container(child:Row(
        children: [
          Text("You've linked your Gmail account.",style:TextStyle(fontSize:15,fontFamily: "NunitoSans", fontWeight: FontWeight.w600)),
          TikiTextButton(
              "Remove",
              () => _removeGmail(),
              trailing: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ConfigColor.orange,
                ),
                child: Icon(Icons.close,color:ConfigColor.orange),
              )
          )
        ],
      )),
      Container(
          padding:EdgeInsets.symmetric(vertical:24, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            //boxShadow: [BoxShadow(offset: Offset(4,4), blurRadius: 20, color:Color(0x33000000))]
          ),
          child: Row(
            children: [
              HelperImage("add-email", width: 35,),
              Expanded(child:Padding(padding:EdgeInsets.symmetric(horizontal: 16),child:Text("Add your\nGmail account", style: TextStyle(fontWeight: FontWeight.bold, fontSize:18, fontFamily: "Montserrat")))),
              HelperImage("right-arrow", width: 30,)
            ],
          )),
      Container(
          width: double.maxFinite,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                margin: EdgeInsets.only(top: 50, bottom:20),
                child: HomeScreenTitle("TIKI updates"))
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
                    child: BlocProvider(
                      create: (BuildContext context) =>
                          HomeCounterCubit.provide(context),
                      child: HomeScreenCounter(),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: HomeScreenRefer()),
                Container(
                    margin:
                        EdgeInsets.symmetric(vertical: _marginVerticalShare),
                    alignment: Alignment.topCenter,
                    child: HomeScreenShare()),
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
          child: HomeScreenLogout()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TikiScaffold(
        foregroundChildren: _foreground(context),
        background: _background(context) as TikiBackground?);
  }

  _removeGmail() {}
}
