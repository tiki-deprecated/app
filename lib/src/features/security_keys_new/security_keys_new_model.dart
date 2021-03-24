/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/security_keys_new/security_keys_new_model_status.dart';
import 'package:app/src/repositories/security_keys/security_keys_model.dart';

class SecurityKeysNewModel {
  SecurityKeysNewModelStatus status = SecurityKeysNewModelStatus.waiting;
  SecurityKeysModel keys;
}
