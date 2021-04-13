/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utilities/utility_exception.dart';

class HelperLogoutException extends UtilityException {
  final String _message;

  HelperLogoutException(String message) : _message = message;

  String get message => _message;

  String toString() => "HelperLogoutException: '$_message'";
}
