/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/security_keys_load/security_keys_load_bloc.dart';
import 'package:app/src/repositories/security_keys/security_keys_bloc.dart';
import 'package:flutter/cupertino.dart';

class SecurityKeysLoadBlocProvider extends InheritedWidget {
  final SecurityKeysLoadBloc _bloc;

  SecurityKeysLoadBlocProvider(SecurityKeysBloc securityKeysBloc,
      {Key key, Widget child})
      : _bloc = SecurityKeysLoadBloc(securityKeysBloc),
        super(key: key, child: child);

  SecurityKeysLoadBloc get bloc => _bloc;

  static SecurityKeysLoadBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SecurityKeysLoadBlocProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
