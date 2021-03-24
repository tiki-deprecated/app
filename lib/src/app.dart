import 'dart:io';

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/entry.dart';
import 'package:app/src/inject.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/screens/screen_intro_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  final _title = 'TIKI';
  static final double _fSize = 4 * PlatformRelativeSize.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    Widget platform;
    if (Platform.isIOS)
      platform = iosApp(context);
    else
      platform = androidApp(context);
    return inject(context, child: platform);
  }

  MaterialApp androidApp(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: EntryPoint(ScreenIntroControl()),
      theme: ThemeData(
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
    );
  }

  CupertinoApp iosApp(BuildContext context) {
    return CupertinoApp(
        title: _title,
        home: EntryPoint(ScreenIntroControl()),
        theme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                textStyle: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.normal,
                    color: ConstantColors.mardiGras,
                    fontSize: _fSize))));
  }
}
