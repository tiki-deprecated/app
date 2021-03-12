import 'package:app/src/screens/screen_create_account.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends PlatformScaffold {
  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold();
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
            child: Container(
                width: 200,
                child: CupertinoTextField(
                  prefix: Text('email'),
                  padding: EdgeInsets.all(10),
                  onSubmitted: (val) {
                    Navigator.push(
                        context, platformPageRoute(ScreenCreateAccount()));
                  },
                ))));
  }
}
