/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc_provider.dart';
import 'package:app/src/ui/ui_security_restore/ui_security_restore_bloc_provider.dart';
import 'package:app/src/ui/ui_security_restore/ui_security_restore_view.dart';
import 'package:flutter/cupertino.dart';

class UISecurityRestore extends StatelessWidget {
  final Function _onComplete;

  UISecurityRestore(this._onComplete);

  @override
  Widget build(BuildContext context) {
    return UISecurityRestoreBlocProvider(
        HelperSecurityKeysBlocProvider.of(context).bloc,
        child: UISecurityRestoreView(_onComplete));
  }
}
