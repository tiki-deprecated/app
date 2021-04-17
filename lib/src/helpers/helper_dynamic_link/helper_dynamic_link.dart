/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class HelperDynamicLink extends StatelessWidget {
  final Widget _child;
  HelperDynamicLink({Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return HelperDynamicLinkBlocProvider(child: _child);
  }
}
