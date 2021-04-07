/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/platform/platform_page_route.dart';
import 'package:app/src/screens/screen_login_otp.dart';
import 'package:uni_links/uni_links.dart';

import '../../app.dart';

class HelperDeepLinkBloc {
  HelperDeepLinkBloc() {
    getInitialLink().then((link) => _processDeeplink(link));
    getLinksStream().listen((link) => _processDeeplink(link));
  }

  Future<void> _processDeeplink(String link) async {
    if (link != null) {
      Uri uri = Uri.parse(link);
      if (uri != null && uri.authority == "bouncer") {
        String otp = uri.queryParameters["otp"];
        navigatorKey.currentState.pushAndRemoveUntil(
            platformPageRoute(ScreenLoginOtp(otp)), (_) => false);
      }
    }
  }
}
