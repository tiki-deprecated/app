import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenSplash extends PlatformScaffold {
  @override
  Scaffold androidScaffold(BuildContext context) {
    RelativeSize().init(context);
    return Scaffold(body: Center(child: Text('splash')));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    RelativeSize().init(context);
    return CupertinoPageScaffold(child: Center(child: Text('splash')));
  }
}
