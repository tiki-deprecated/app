/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/app.dart';
import 'package:app/src/helpers/helper_logout/helper_logout_exception.dart';
import 'package:app/src/platform/platform_page_route.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/screens/screen_login.dart';

class HelperLogoutBloc {
  final RepoSSUserBloc _repoSSUserBloc;

  HelperLogoutBloc(this._repoSSUserBloc);

  Future<void> logout() async {
    await _repoSSUserBloc.setLoggedIn(false);
    navigatorKey.currentState
        .pushAndRemoveUntil(platformPageRoute(ScreenLogin()), (_) => false);
  }

  Future<Exception> logoutWithException(String message) async {
    await _repoSSUserBloc.setLoggedIn(false);
    navigatorKey.currentState
        .pushAndRemoveUntil(platformPageRoute(ScreenLogin()), (_) => false);
    return HelperLogoutException(
            "Attempt to register a blockchain address for a non-existent or a not logged-in user")
        .sentry();
  }
}
