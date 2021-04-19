/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_auth_proxy/helper_auth_proxy.dart';
import 'package:app/src/helpers/helper_logout/helper_logout.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys.dart';
import 'package:app/src/repos/repo_amplitude/repo_amplitude.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt.dart';
import 'package:app/src/repos/repo_bouncer_otp/repo_bouncer_otp.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user.dart';
import 'package:app/src/repos/repo_website_users/repo_website_users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'helpers/helper_dynamic_link/helper_dynamic_link.dart';

Widget chain(BuildContext context, {Widget child}) {
  return _ss(
      child: HelperDynamicLink(
          child: _bouncer(
              child: _blockchain(
                  child: RepoWebsiteUsers(
                      child: HelperSecurityKeys(
                          child: RepoAmplitude(child: child)))))));
}

Widget _ss({Widget child}) {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  return RepoSSSecurityKeys(secureStorage,
      child: RepoSSUser(secureStorage, child: HelperLogout(child: child)));
}

Widget _bouncer({Widget child}) {
  return RepoBouncerOtp(
      child: RepoBouncerJwt(child: HelperAuthProxy(child: child)));
}

Widget _blockchain({Widget child}) {
  return RepoBlockchainAddress(child: child);
}
