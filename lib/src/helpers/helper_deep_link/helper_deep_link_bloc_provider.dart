/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_deep_link/helper_deep_link_bloc.dart';
import 'package:app/src/helpers/helper_login/helper_login_bloc.dart';
import 'package:flutter/widgets.dart';

class HelperDeepLinkBlocProvider extends InheritedWidget {
  final HelperDeepLinkBloc _bloc;

  HelperDeepLinkBlocProvider(HelperLoginBloc helperLoginRouterBloc,
      {Key key, Widget child})
      : _bloc = HelperDeepLinkBloc(helperLoginRouterBloc),
        super(key: key, child: child);

  HelperDeepLinkBloc get bloc => _bloc;

  static HelperDeepLinkBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HelperDeepLinkBlocProvider>();
  }

  @override
  bool updateShouldNotify(HelperDeepLinkBlocProvider oldWidget) {
    return false;
  }
}
