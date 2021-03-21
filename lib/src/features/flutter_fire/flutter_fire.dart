import 'package:app/src/screens/screen_intro_control.dart';
import 'package:app/src/screens/screen_splash.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class FlutterFire extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    RelativeSize().init(context);
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('ERROR LOADING FLUTTER FIRE');
          return ScreenSplash();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ScreenIntroControl();
        }
        return ScreenSplash();
      },
    );
  }
}
