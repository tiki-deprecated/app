/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/security_keys_new/security_keys_new_bloc_provider.dart';
import 'package:app/src/features/security_keys_new/security_keys_new_ui.dart';
import 'package:flutter/widgets.dart';

class SecurityKeysNew extends StatelessWidget {
  final Function _onComplete;

  SecurityKeysNew(this._onComplete);

  @override
  Widget build(BuildContext context) {
    return SecurityKeysNewBlocProvider(child: SecurityKeysNewUI(_onComplete));
  }
}
