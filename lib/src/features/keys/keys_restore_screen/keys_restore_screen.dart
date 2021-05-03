/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/keys/keys_restore_screen/keys_restore_screen_back.dart';
import 'package:app/src/features/keys/keys_restore_screen/keys_restore_screen_bloc.dart';
import 'package:app/src/features/keys/keys_restore_screen/keys_restore_screen_input_id.dart';
import 'package:app/src/features/keys/keys_restore_screen/keys_restore_screen_scan.dart';
import 'package:app/src/features/keys/keys_restore_screen/keys_restore_screen_submit.dart';
import 'package:app/src/features/keys/keys_restore_screen/keys_restore_screen_subtitle.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/utils/platform/platform_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'keys_restore_screen_divider.dart';
import 'keys_restore_screen_input_data.dart';
import 'keys_restore_screen_input_sign.dart';
import 'keys_restore_screen_title.dart';

class KeysRestoreScreen extends PlatformScaffold {
  static final double _marginTopBack = 4.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopTitle = 4 * PlatformRelativeSize.blockVertical;
  static final double _marginTopSubtitle =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopScan = 2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginHorizontalInput =
      14 * PlatformRelativeSize.blockHorizontal;
  static final double _marginVerticalDivider =
      5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopInput =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopSubmit = 5 * PlatformRelativeSize.blockVertical;

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: screen(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: screen(context));
  }

  Widget screen(BuildContext context) {
    return Stack(children: [
      _background(),
      BlocProvider(
          create: (BuildContext context) =>
              KeysRestoreScreenBloc.provide(context),
          child: BlocListener<KeysRestoreScreenBloc, KeysRestoreScreenState>(
              listener: (BuildContext context, KeysRestoreScreenState state) {
                if (state is KeysRestoreScreenSuccess)
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      ConfigNavigate.path.home, (route) => false);
              },
              child: _foreground(context)))
    ]);
  }

  Widget _background() {
    return Stack(
      children: [
        Container(color: ConfigColor.serenade),
        Container(
            alignment: Alignment.topRight, child: HelperImage("keys-blob")),
      ],
    );
  }

  Widget _foreground(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: PlatformRelativeSize.marginHorizontal),
      child: Column(children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: _marginTopBack),
          child: KeysRestoreScreenBack(),
        ),
        Container(
            margin: EdgeInsets.only(top: _marginTopTitle),
            alignment: Alignment.center,
            child: KeysRestoreScreenTitle()),
        Container(
            margin: EdgeInsets.only(top: _marginTopSubtitle),
            alignment: Alignment.center,
            child: KeysRestoreScreenSubtitle()),
        Container(
            margin: EdgeInsets.symmetric(horizontal: _marginHorizontalInput),
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: _marginTopScan),
                alignment: Alignment.center,
                child: KeysRestoreScreenScan(),
              ),
              Container(
                  margin:
                      EdgeInsets.symmetric(vertical: _marginVerticalDivider),
                  child: KeysRestoreScreenDivider()),
              Container(child: KeysRestoreScreenInputId()),
              Container(
                  margin: EdgeInsets.only(top: _marginTopInput),
                  child: KeysRestoreScreenInputData()),
              Container(
                  margin: EdgeInsets.only(top: _marginTopInput),
                  child: KeysRestoreScreenInputSign()),
              Container(
                  margin: EdgeInsets.only(top: _marginTopSubmit),
                  child: KeysRestoreScreenSubmit())
            ]))
      ]),
    );
  }
}
