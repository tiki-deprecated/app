/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/ui/ui_security_create/ui_security_create_view.dart';
import 'package:flutter/widgets.dart';

class UISecurityCreate extends StatelessWidget {
  final Function _onComplete;

  UISecurityCreate(this._onComplete);

  @override
  Widget build(BuildContext context) {
    return UISecurityCreateView(_onComplete);
  }
}
