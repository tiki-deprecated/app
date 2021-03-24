/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/ui/ui_deeplink_inbox/ui_deeplink_inbox_bloc.dart';
import 'package:flutter/cupertino.dart';

class UIDeeplinkInboxBlocProvider extends InheritedWidget {
  final UIDeeplinkInboxBloc _bloc;

  UIDeeplinkInboxBlocProvider({Key key, Widget child})
      : _bloc = UIDeeplinkInboxBloc(),
        super(key: key, child: child);

  UIDeeplinkInboxBloc get bloc => _bloc;

  static UIDeeplinkInboxBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UIDeeplinkInboxBlocProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
