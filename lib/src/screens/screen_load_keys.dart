import 'package:app/src/screens/screen_home.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenLoadKeys extends PlatformScaffold {
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
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: CupertinoButton(
                          child: Text('upload'),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context, platformPageRoute(ScreenHome()));
                          },
                        )),
                    Text('or'),
                    Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: CupertinoButton(
                          child: Text('scan'),
                          color: Colors.black,
                          onPressed: () {},
                        )),
                    Text('or'),
                    Container(
                        width: 200,
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: CupertinoTextField(
                            prefix: Text('secret'),
                            padding: EdgeInsets.all(10),
                            onSubmitted: (val) {})),
                    Container(
                        width: 200,
                        child: CupertinoTextField(
                            prefix: Text('wallet'),
                            padding: EdgeInsets.all(10),
                            onSubmitted: (val) {}))
                  ],
                ))));
  }
}
