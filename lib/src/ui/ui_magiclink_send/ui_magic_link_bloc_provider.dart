/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/ui/ui_magiclink_send/ui_magic_link_bloc.dart';
import 'package:flutter/cupertino.dart';

class UIMagicLinkBlocProvider extends InheritedWidget {
  final UIMagicLinkBloc _bloc;

  UIMagicLinkBlocProvider({Key key, Widget child})
      : _bloc = UIMagicLinkBloc(),
        super(key: key, child: child);

  UIMagicLinkBloc get bloc => _bloc;

  static UIMagicLinkBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UIMagicLinkBlocProvider>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
