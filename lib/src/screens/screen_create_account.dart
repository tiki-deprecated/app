import 'package:app/src/screens/screen_home.dart';
import 'package:app/src/screens/screen_load_keys.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenCreateAccount extends PlatformScaffold {
  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold();
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
            child: Container(
      margin: EdgeInsets.only(top: 200),
      child: Column(
        children: [
          Container(
              color: Colors.black,
              height: 150,
              width: 150,
              margin: EdgeInsets.only(bottom: 10)),
          Text('Secret: xaoheitoahfeaifoh'),
          Text('Wallet: faieoahfeiageoaig'),
          Container(
              margin: EdgeInsets.only(top: 200, bottom: 125),
              child: CupertinoButton(
                  child: Text('save'),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(context, platformPageRoute(ScreenHome()));
                  })),
          TextButton(
              onPressed: () {
                Navigator.push(context, platformPageRoute(ScreenLoadKeys()));
              },
              child: Text('I already have an account'))
        ],
      ),
    )));
  }
}
