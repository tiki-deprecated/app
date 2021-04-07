/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_security_keys/helper_security_keys.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt.dart';
import 'package:app/src/repos/repo_bouncer_otp/repo_bouncer_otp.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user.dart';
import 'package:app/src/repos/repo_website_users/repo_website_users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'helpers/helper_deep_link/helper_deep_link.dart';

Widget chain(BuildContext context, {Key key, Widget child}) {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  return RepoSSSecurityKeys(secureStorage,
      child: RepoSSUser(secureStorage,
          child: RepoBouncerOtp(
              child: RepoBouncerJwt(
                  child: RepoWebsiteUsers(
                      child: HelperSecurityKeys(
                          child: HelperDeepLink(child: child)))))));
}
