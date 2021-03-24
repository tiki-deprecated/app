/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc_provider.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_bloc_provider.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class HelperSecurityKeys extends StatelessWidget {
  final child;
  HelperSecurityKeys(this.child);

  @override
  Widget build(BuildContext context) {
    return HelperSecurityKeysBlocProvider(
        RepoSSUserBlocProvider.of(context).bloc,
        RepoSSSecurityKeysBlocProvider.of(context).bloc,
        child: child);
  }
}
