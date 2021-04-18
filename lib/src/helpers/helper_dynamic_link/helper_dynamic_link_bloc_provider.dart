/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc.dart';
import 'package:flutter/cupertino.dart';

class HelperDynamicLinkBlocProvider extends InheritedWidget {
  final HelperDynamicLinkBloc _bloc;

  HelperDynamicLinkBlocProvider({Key key, Widget child})
      : _bloc = HelperDynamicLinkBloc(),
        super(key: key, child: child);

  HelperDynamicLinkBloc get bloc => _bloc;

  static HelperDynamicLinkBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HelperDynamicLinkBlocProvider>();
  }

  @override
  bool updateShouldNotify(HelperDynamicLinkBlocProvider oldWidget) {
    return false;
  }
}
