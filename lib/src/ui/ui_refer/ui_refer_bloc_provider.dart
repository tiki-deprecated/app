/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/ui/ui_refer/ui_refer_bloc.dart';
import 'package:flutter/cupertino.dart';

class UIReferBlocProvider extends InheritedWidget {
  final UIReferBloc _bloc;

  UIReferBlocProvider({Key key, Widget child})
      : _bloc = UIReferBloc(),
        super(key: key, child: child);

  UIReferBloc get bloc => _bloc;

  static UIReferBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UIReferBlocProvider>();
  }

  @override
  bool updateShouldNotify(UIReferBlocProvider oldWidget) {
    return false;
  }
}
