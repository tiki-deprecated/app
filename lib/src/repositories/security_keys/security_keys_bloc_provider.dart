/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repositories/security_keys/security_keys_bloc.dart';
import 'package:flutter/cupertino.dart';

class SecurityKeysBlocProvider extends InheritedWidget {
  final SecurityKeysBloc _bloc;

  SecurityKeysBlocProvider({Key key, Widget child})
      : _bloc = SecurityKeysBloc(),
        super(key: key, child: child);

  SecurityKeysBloc get bloc => _bloc;

  static SecurityKeysBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SecurityKeysBlocProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
