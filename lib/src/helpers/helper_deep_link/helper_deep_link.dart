/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_deep_link/helper_deep_link_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class HelperDeepLink extends StatelessWidget {
  final Widget _child;

  HelperDeepLink({Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return HelperDeepLinkBlocProvider(child: _child);
  }
}
