/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/helpers/helper_login_router/helper_login_router_bloc_provider.dart';
import 'package:app/src/helpers/helper_login_router/helper_login_router_model.dart';
import 'package:app/src/helpers/helper_login_router/helper_login_router_model_state.dart';
import 'package:app/src/platform/platform_scaffold.dart';
import 'package:app/src/screens/screen_home.dart';
import 'package:app/src/screens/screen_intro_control.dart';
import 'package:app/src/screens/screen_keys_create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenSplash extends PlatformScaffold {
  static final Color _backgroundColor = ConstantColors.sunglow;
  static final Widget _loggedIn = ScreenHome();
  static final Widget _loggedOut = ScreenIntroControl();
  static final Widget _create = ScreenKeysCreate();

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: _stack(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _stack(context));
  }

  Widget _stack(BuildContext context) {
    return StreamBuilder(
        stream: HelperLoginRouterBlocProvider.of(context).bloc.observable,
        initialData: HelperLoginRouterModel(),
        builder: (context, AsyncSnapshot<HelperLoginRouterModel> snapshot) {
          if (snapshot.data.state == HelperLoginRouterModelState.loggedOut)
            return _loggedOut;
          else if (snapshot.data.state == HelperLoginRouterModelState.create)
            return _create;
          else if (snapshot.data.state == HelperLoginRouterModelState.loggedIn)
            return _loggedIn;
          return Stack(children: [
            Center(child: Container(color: _backgroundColor)),
            Align(
                alignment: Alignment.topLeft,
                child:
                    Image(image: AssetImage('res/images/splash-blob-tl.png'))),
            Stack(children: [
              Center(
                  child: Image(
                      image: AssetImage('res/images/splash-logo-bkg.png'))),
              Center(
                  child: Image(image: AssetImage('res/images/splash-logo.png')))
            ]),
            Align(
                alignment: Alignment.bottomRight,
                child:
                    Image(image: AssetImage('res/images/splash-blob-br.png'))),
          ]);
        });
  }
}
