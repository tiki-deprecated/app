/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/security_keys_new/security_keys_new_bloc.dart';
import 'package:flutter/widgets.dart';

class SecurityKeysNewBlocProvider extends InheritedWidget {
  final SecurityKeysNewBloc _bloc;

  SecurityKeysNewBlocProvider({Key key, Widget child})
      : _bloc = SecurityKeysNewBloc(),
        super(key: key, child: child);

  SecurityKeysNewBloc get bloc => _bloc;

  static SecurityKeysNewBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SecurityKeysNewBlocProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
