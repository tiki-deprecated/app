import 'dart:io';

import 'package:app/src/screens/screen_intro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final _title = 'TIKI';

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return iosApp(context);
    else
      return androidApp(context);
  }

  MaterialApp androidApp(BuildContext context) {
    return MaterialApp(
      home: ScreenIntro(),
      title: _title,
    );
  }

  CupertinoApp iosApp(BuildContext context) {
    return CupertinoApp(
      home: ScreenIntro(),
      title: _title,
    );
  }
}
