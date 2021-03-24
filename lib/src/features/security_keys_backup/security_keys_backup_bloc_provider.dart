/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/security_keys_backup/security_keys_backup_bloc.dart';
import 'package:app/src/repositories/security_keys/security_keys_model.dart';
import 'package:flutter/cupertino.dart';

class SecurityKeysBackupBlocProvider extends InheritedWidget {
  final SecurityKeysBackupBloc _bloc;

  SecurityKeysBackupBlocProvider(
      {Key key, Widget child, SecurityKeysModel keys})
      : _bloc = SecurityKeysBackupBloc(keys: keys),
        super(key: key, child: child);

  SecurityKeysBackupBloc get bloc => _bloc;

  static SecurityKeysBackupBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SecurityKeysBackupBlocProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
