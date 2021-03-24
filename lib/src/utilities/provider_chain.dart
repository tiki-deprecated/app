/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repositories/security_keys/security_keys_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

Widget providerChain(Widget child) {
  return SecurityKeysBlocProvider(child: child);
}
