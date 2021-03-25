/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_sizes.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/platform/platform_page_route.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/platform/platform_scaffold.dart';
import 'package:app/src/screens/screen_home.dart';
import 'package:app/src/ui/ui_security_restore/ui_security_restore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenKeysLoad extends PlatformScaffold {
  static final double _hPadding =
      ConstantSizes.hPadding * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vMarginStart =
      15 * PlatformRelativeSize.safeBlockVertical;
  static final double _vMargin = 2.5 * PlatformRelativeSize.safeBlockVertical;
  static final double _fSizeTitle =
      10 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeSubtitle =
      5 * PlatformRelativeSize.safeBlockHorizontal;
  final Widget _toHome = ScreenHome();

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(
      body: stack(context),
    );
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(
      child: stack(context),
    );
  }

  Widget stack(BuildContext context) {
    //TODO fix scrolling mess. It should not display behind status icons, it should auto-scroll to bottom. It's very messy code.
    return GestureDetector(
      child: Stack(
        children: [
          _background(),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: _foreground(context)),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConstantColors.serenade,
        ),
        Container(
            child: Align(
                alignment: Alignment.topRight,
                child: Image(image: AssetImage('res/images/keys-blob.png')))),
      ],
    );
  }

  Widget _foreground(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: _hPadding, right: _hPadding),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _title(),
        _subtitle(),
        UISecurityRestore((keys) {
          Navigator.pushAndRemoveUntil(
              context, platformPageRoute(_toHome), (route) => false);
        })
      ]),
    );
  }

  Widget _title() {
    return Container(
        margin: EdgeInsets.only(top: _vMarginStart),
        child: Align(
            alignment: Alignment.center,
            child: Text(ConstantStrings.keysLoadTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: _fSizeTitle,
                    fontWeight: FontWeight.bold,
                    color: ConstantColors.mardiGras))));
  }

  Widget _subtitle() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: _vMargin),
        child: Align(
            alignment: Alignment.center,
            child: Text(ConstantStrings.keysLoadSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: _fSizeSubtitle,
                    fontWeight: FontWeight.w600,
                    color: ConstantColors.emperor))));
  }
}
