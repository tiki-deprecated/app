/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login/helper_login_bloc.dart';
import 'package:uni_links/uni_links.dart';

class HelperDeepLinkBloc {
  HelperLoginBloc _loginRouterBloc;

  HelperDeepLinkBloc(this._loginRouterBloc) {
    getInitialLink().then((link) => _processDeeplink(link));
    getLinksStream().listen((link) => _processDeeplink(link));
  }

  Future<void> _processDeeplink(String link) async {
    if (link != null) {
      Uri uri = Uri.parse(link);
      if (uri != null && uri.authority == "bouncer") {
        String otp = uri.queryParameters["otp"];
        await _loginRouterBloc.beginOtp(otp);
      }
    }
  }
}
