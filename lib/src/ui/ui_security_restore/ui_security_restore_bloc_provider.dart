/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc.dart';
import 'package:app/src/ui/ui_security_restore/ui_security_restore_bloc.dart';
import 'package:flutter/cupertino.dart';

class UISecurityRestoreBlocProvider extends InheritedWidget {
  final UISecurityRestoreBloc _bloc;

  UISecurityRestoreBlocProvider(HelperSecurityKeysBloc helperSecurityKeysBloc,
      {Key key, Widget child})
      : _bloc = UISecurityRestoreBloc(helperSecurityKeysBloc),
        super(key: key, child: child);

  UISecurityRestoreBloc get bloc => _bloc;

  static UISecurityRestoreBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UISecurityRestoreBlocProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
