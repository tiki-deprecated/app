/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/platform/platform_relative_size.dart';
import 'package:flutter/widgets.dart';

class EntryPoint extends StatelessWidget {
  final Widget _child;

  EntryPoint(this._child);

  @override
  Widget build(BuildContext context) {
    PlatformRelativeSize().init(context);
    return _child;
  }
}
