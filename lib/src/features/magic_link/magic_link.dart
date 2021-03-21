/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/magic_link/magic_link_ui.dart';
import 'package:flutter/cupertino.dart';

import 'magic_link_bloc_provider.dart';

class MagicLink extends StatelessWidget {
  final Widget _onSubmit;

  MagicLink(this._onSubmit);

  @override
  Widget build(BuildContext context) {
    return MagicLinkBlocProvider(child: MagicLinkUI(_onSubmit));
  }
}
