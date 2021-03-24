/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_security_keys/helper_security_keys.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Widget inject(BuildContext context, {Key key, Widget child}) {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  return RepoSSSecurityKeys(
      secureStorage, RepoSSUser(secureStorage, HelperSecurityKeys(child)));
}

//Future<Null> initUniLinks() async {
//   String initialLink = await getInitialLink();
//   getLinksStream().listen((String link) {
//     print('hmm something');
//   });
//   print('hot diggidy');
// }
