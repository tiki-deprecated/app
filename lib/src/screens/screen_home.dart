import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenHome extends PlatformScaffold {
  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold();
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    printNotificationId();
    return CupertinoPageScaffold(child: Center(child: Text('home')));
  }

  Future<void> printNotificationId() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String token = (await messaging.getToken())!;
    print(token);
  }
}
