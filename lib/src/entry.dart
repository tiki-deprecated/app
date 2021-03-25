/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login_router/helper_login_router_bloc_provider.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:flutter/widgets.dart';

class EntryPoint extends StatelessWidget {
  final Widget _child;

  EntryPoint(this._child);

  @override
  Widget build(BuildContext context) {
    PlatformRelativeSize().init(context);
    HelperLoginRouterBlocProvider.of(context).bloc.login();
    return _child;
  }
}
