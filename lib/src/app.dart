import 'dart:io';

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/features/flutter_fire/flutter_fire.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  final _title = 'TIKI';
  static final double _fSize = 4 * RelativeSize.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return iosApp(context);
    else
      return androidApp(context);
  }

  MaterialApp androidApp(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: FlutterFire(),
      theme: ThemeData(
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
    );
  }

  CupertinoApp iosApp(BuildContext context) {
    return CupertinoApp(
        title: _title,
        home: FlutterFire(),
        theme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                textStyle: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.normal,
                    color: ConstantColors.mardiGras,
                    fontSize: _fSize))));
  }
}
