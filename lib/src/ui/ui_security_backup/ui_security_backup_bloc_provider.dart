/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_model.dart';
import 'package:app/src/ui/ui_security_backup/ui_security_backup_bloc.dart';
import 'package:flutter/cupertino.dart';

class UISecurityBackupBlocProvider extends InheritedWidget {
  final UISecurityBackupBloc _bloc;

  UISecurityBackupBlocProvider(HelperSecurityKeysBloc helperSecurityKeysBloc,
      {Key key, Widget child, HelperSecurityKeysModel provided})
      : _bloc =
            UISecurityBackupBloc(helperSecurityKeysBloc, provided: provided),
        super(key: key, child: child);

  UISecurityBackupBloc get bloc => _bloc;

  static UISecurityBackupBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UISecurityBackupBlocProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
