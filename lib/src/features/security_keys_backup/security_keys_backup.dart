/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/security_keys_backup/security_keys_backup_bloc_provider.dart';
import 'package:app/src/features/security_keys_backup/security_keys_backup_ui.dart';
import 'package:app/src/repositories/security_keys/security_keys_model.dart';
import 'package:flutter/cupertino.dart';

class SecurityKeysBackup extends StatelessWidget {
  final SecurityKeysModel _keys;
  final Function _onSave;

  SecurityKeysBackup(this._onSave, {SecurityKeysModel keys})
      : this._keys = keys;

  @override
  Widget build(BuildContext context) {
    return SecurityKeysBackupBlocProvider(
      child: SecurityKeysBackupUI(_onSave),
      keys: _keys,
    );
  }
}
