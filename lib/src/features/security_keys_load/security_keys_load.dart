/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/security_keys_load/security_keys_load_bloc_provider.dart';
import 'package:app/src/features/security_keys_load/security_keys_load_ui.dart';
import 'package:app/src/repositories/security_keys/security_keys_bloc.dart';
import 'package:flutter/cupertino.dart';

class SecurityKeysLoad extends StatelessWidget {
  final Function _onComplete;
  final SecurityKeysBloc _securityKeysBloc;

  SecurityKeysLoad(this._securityKeysBloc, this._onComplete);

  @override
  Widget build(BuildContext context) {
    return SecurityKeysLoadBlocProvider(_securityKeysBloc,
        child: SecurityKeysLoadUI(_onComplete));
  }
}
