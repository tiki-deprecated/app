/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_logout/helper_logout_bloc_provider.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class HelperLogout extends StatelessWidget {
  final Widget _child;

  HelperLogout({Widget child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return HelperLogoutBlocProvider(RepoSSUserBlocProvider.of(context).bloc,
        child: _child);
  }
}
