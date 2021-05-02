/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/home/home_counter/home_counter_cubit.dart';
import 'package:app/src/features/home/home_screen/home_screen_counter.dart';
import 'package:app/src/features/home/home_screen/home_screen_refer.dart';
import 'package:app/src/features/home/home_screen/home_screen_share.dart';
import 'package:app/src/features/home/home_screen/home_screen_title.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/utils/platform/platform_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends PlatformScaffold {
  static final double _marginTopTitle = 20 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCount = 8 * PlatformRelativeSize.blockVertical;
  static final double _marginTopRefer = 8 * PlatformRelativeSize.blockVertical;
  static final double _marginTopShare = 8 * PlatformRelativeSize.blockVertical;

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: _screen(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _screen(context));
  }

  Widget _screen(BuildContext context) {
    return Stack(children: [_background(), _foreground(context)]);
  }

  Widget _background() {
    return Stack(children: [
      Center(child: Container(color: ConfigColor.serenade)),
      Align(
          alignment: Alignment.topRight,
          child: Image(image: AssetImage('res/images/home-blob-tr.png'))),
      Align(
          alignment: Alignment.bottomRight,
          child: Image(image: AssetImage('res/images/home-pineapple.png')))
    ]);
  }

  Widget _foreground(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: PlatformRelativeSize.marginHorizontal2x),
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(top: _marginTopTitle),
                    alignment: Alignment.center,
                    child: HomeScreenTitle()),
                Container(
                    margin: EdgeInsets.only(top: _marginTopCount),
                    child: BlocProvider(
                      create: (BuildContext context) =>
                          HomeCounterCubit.provide(context),
                      child: HomeScreenCounter(),
                    )),
                Container(
                    margin: EdgeInsets.only(top: _marginTopRefer),
                    child: HomeScreenRefer()),
                Container(
                    margin: EdgeInsets.only(top: _marginTopShare),
                    alignment: Alignment.center,
                    child: HomeScreenShare())
              ])))
    ]);
  }
}
