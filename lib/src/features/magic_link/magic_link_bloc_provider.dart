/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/magic_link/magic_link_bloc.dart';
import 'package:flutter/cupertino.dart';

class MagicLinkBlocProvider extends InheritedWidget {
  final MagicLinkBloc _bloc;

  MagicLinkBlocProvider({Key key, Widget child})
      : _bloc = MagicLinkBloc(),
        super(key: key, child: child);

  MagicLinkBloc get bloc => _bloc;

  static MagicLinkBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MagicLinkBlocProvider>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
