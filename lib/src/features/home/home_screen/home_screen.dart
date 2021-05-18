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
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen_logout.dart';

class HomeScreen extends StatelessWidget {
  static final double _marginTopTitle = 20 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCount = 8 * PlatformRelativeSize.blockVertical;
  static final double _marginTopRefer = 8 * PlatformRelativeSize.blockVertical;
  static final double _marginTopShare = 8 * PlatformRelativeSize.blockVertical;
  static final double _marginBottomLogOut =
      4 * PlatformRelativeSize.blockVertical;

  Widget _background() {
    return TikiBackground(
      backgroundColor: ConfigColor.serenade,
      topRight: HelperImage("home-blob-tr"),
      bottomRight: HelperImage("home-pineapple"),
    );
  }

  List<Widget> _foreground(BuildContext context) {
    return [
      Container(
          margin: EdgeInsets.only(top: _marginTopTitle),
          alignment: Alignment.center,
          child: HomeScreenTitle()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCount),
          child: BlocProvider(
            create: (BuildContext context) => HomeCounterCubit.provide(context),
            child: HomeScreenCounter(),
          )),
      Container(
          margin: EdgeInsets.only(top: _marginTopRefer),
          child: HomeScreenRefer()),
      Container(
          margin: EdgeInsets.only(top: _marginTopShare),
          alignment: Alignment.topCenter,
          child: HomeScreenShare()),
     Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: _marginBottomLogOut),
              child: HomeScreenLogout())
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TikiScaffold(
        foregroundChildren: _foreground(context), background: _background());
  }
}
