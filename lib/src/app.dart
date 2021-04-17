import 'dart:io';

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/entry.dart';
import 'package:app/src/inject.dart' as Inject;
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/screens/screen_login_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  static const _title = 'TIKI';
  static final double _fSize = 4 * PlatformRelativeSize.safeBlockHorizontal;
  static const String appPathLoginOtp = "/login-otp";
  static const String appPathEntry = "/";
  final RepoSSUserModel _user;

  App(this._user);

  @override
  Widget build(BuildContext context) => Inject.chain(context,
      child: Platform.isIOS ? iosApp(context) : androidApp(context));

  MaterialApp androidApp(BuildContext context) {
    return MaterialApp(
      title: _title,
      routes: <String, WidgetBuilder>{
        appPathEntry: (BuildContext context) => Entry(_user),
        appPathLoginOtp: (BuildContext context) => ScreenLoginOtp(),
      },
      navigatorKey: navigatorKey,
      theme: ThemeData(
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
    );
  }

  CupertinoApp iosApp(BuildContext context) {
    return CupertinoApp(
        title: _title,
        routes: <String, WidgetBuilder>{
          appPathEntry: (BuildContext context) => Entry(_user),
          appPathLoginOtp: (BuildContext context) => ScreenLoginOtp(),
        },
        navigatorKey: navigatorKey,
        theme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                textStyle: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.normal,
                    color: ConfigColors.mardiGras,
                    fontSize: _fSize))));
  }
}
