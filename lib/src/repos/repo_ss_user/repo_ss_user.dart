/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RepoSSUser extends StatelessWidget {
  final Widget _child;
  final FlutterSecureStorage _secureStorage;
  RepoSSUser(this._secureStorage, this._child);

  @override
  Widget build(BuildContext context) {
    return RepoSSUserBlocProvider(_secureStorage, child: _child);
  }
}
