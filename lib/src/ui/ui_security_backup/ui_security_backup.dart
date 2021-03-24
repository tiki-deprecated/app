/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc_provider.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_model.dart';
import 'package:app/src/ui/ui_security_backup/ui_security_backup_bloc_provider.dart';
import 'package:app/src/ui/ui_security_backup/ui_security_backup_view.dart';
import 'package:flutter/cupertino.dart';

class UISecurityBackup extends StatelessWidget {
  final Function _onSave;
  final HelperSecurityKeysModel _provided;

  UISecurityBackup(this._onSave, {HelperSecurityKeysModel provided})
      : this._provided = provided;

  @override
  Widget build(BuildContext context) {
    return UISecurityBackupBlocProvider(
      HelperSecurityKeysBlocProvider.of(context).bloc,
      child: UISecurityBackupView(_onSave),
      provided: _provided,
    );
  }
}
