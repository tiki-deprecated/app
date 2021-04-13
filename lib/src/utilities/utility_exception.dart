/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sentry_flutter/sentry_flutter.dart';

abstract class UtilityException implements Exception {
  Future<UtilityException> sentry() async {
    await Sentry.captureException(this, stackTrace: StackTrace.current);
    return this;
  }
}
