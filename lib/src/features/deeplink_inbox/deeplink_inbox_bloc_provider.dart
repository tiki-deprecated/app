/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/deeplink_inbox/deeplink_inbox_bloc.dart';
import 'package:flutter/cupertino.dart';

class DeeplinkInboxBlocProvider extends InheritedWidget {
  final DeeplinkInboxBloc _bloc;

  DeeplinkInboxBlocProvider({Key key, Widget child})
      : _bloc = DeeplinkInboxBloc(),
        super(key: key, child: child);

  DeeplinkInboxBloc get bloc => _bloc;

  static DeeplinkInboxBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DeeplinkInboxBlocProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
