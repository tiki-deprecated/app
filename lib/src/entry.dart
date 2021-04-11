/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/repos/repo_amplitude/repo_amplitude_bloc_provider.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/screens/screen_home.dart';
import 'package:app/src/screens/screen_intro_control.dart';
import 'package:flutter/widgets.dart';

class Entry extends StatelessWidget {
  final RepoSSUserModel _user;

  Entry(this._user);

  @override
  Widget build(BuildContext context) {
    PlatformRelativeSize().init(context);
    return FutureBuilder<void>(
        future: RepoAmplitudeBlocProvider.of(context).bloc.init(),
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (_user != null && _user.loggedIn)
            return ScreenHome();
          else
            return ScreenIntroControl();
        });
  }
}
