/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_strings.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc_provider.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_model.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/platform/platform_scaffold.dart';
import 'package:app/src/screens/screen_intro_abstract.dart';
import 'package:app/src/ui/ui_refer/ui_refer.dart';
import 'package:app/src/ui/ui_user_counter/ui_user_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class ScreenHome extends PlatformScaffold {
  static final double _vMarginTitle =
      20 * PlatformRelativeSize.safeBlockVertical;
  static final double _fSizeTitle =
      10 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vMargin = 8 * PlatformRelativeSize.safeBlockVertical;
  static final double _heightButton =
      8 * PlatformRelativeSize.safeBlockVertical;
  static final double _widthButton =
      50 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeButton =
      6 * PlatformRelativeSize.safeBlockHorizontal;

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: _stack(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _stack(context));
  }

  Widget _stack(BuildContext context) {
    return Stack(children: [_background(), _foreground(context)]);
  }

  Widget _background() {
    return Stack(children: [
      Center(child: Container(color: ConfigColors.serenade)),
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
                  horizontal: ScreenIntroAbstract.hPadding),
              child: Column(children: [
                title(),
                Container(
                    margin: EdgeInsets.only(top: _vMargin),
                    child: UIUserCounter()),
                Container(
                    margin: EdgeInsets.only(top: _vMargin), child: UIRefer()),
                share(context)
              ])))
    ]);
  }

  Widget title() {
    return Container(
        margin: EdgeInsets.only(top: _vMarginTitle),
        child: Align(
            alignment: Alignment.center,
            child: Text(ConfigStrings.homeTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: _fSizeTitle,
                    fontWeight: FontWeight.bold))));
  }

  Widget share(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Align(
            alignment: Alignment.center,
            child: FutureBuilder(
                future: HelperSecurityKeysBlocProvider.of(context).bloc.load(),
                builder: (BuildContext context,
                    AsyncSnapshot<HelperSecurityKeysModel> snapshot) {
                  String refer = snapshot.data?.refer == null
                      ? "https://mytiki.app"
                      : snapshot.data.refer;
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_vMargin * 2))),
                          primary: ConfigColors.mardiGras),
                      child: Container(
                        width: _widthButton,
                        height: _heightButton,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("SHARE",
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: _fSizeButton,
                                  letterSpacing: 0.05 *
                                      PlatformRelativeSize.safeBlockHorizontal,
                                )),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3 *
                                        PlatformRelativeSize
                                            .safeBlockHorizontal),
                                child: Image(
                                    image: AssetImage(
                                        "res/images/icon-share.png")))
                          ],
                        ),
                      ),
                      onPressed: () {
                        Share.share("You need to see this! " + refer,
                            subject: "You wont believe what they're building.");
                      });
                })));
  }
}
