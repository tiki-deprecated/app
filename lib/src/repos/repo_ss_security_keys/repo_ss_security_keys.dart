/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RepoSSSecurityKeys extends StatelessWidget {
  final Widget _child;
  final FlutterSecureStorage _secureStorage;
  RepoSSSecurityKeys(this._secureStorage, {Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return RepoSSSecurityKeysBlocProvider(_secureStorage, child: _child);
  }
}
