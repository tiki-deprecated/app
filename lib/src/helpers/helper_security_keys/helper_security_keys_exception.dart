/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utilities/utility_exception.dart';

class HelperSecurityKeysException extends UtilityException {
  final String _message;

  HelperSecurityKeysException(String message) : _message = message;

  String get message => _message;

  String toString() => "HelperSecurityKeysException: '$_message'";
}
