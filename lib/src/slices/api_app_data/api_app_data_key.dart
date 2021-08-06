/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

enum ApiAppDataKey {
  decisionCardsTestDone,
}

extension ApiAppDataKeyExtension on ApiAppDataKey {
  String? get value {
    switch (this) {
      case ApiAppDataKey.decisionCardsTestDone:
        return 'decision cards test done';
      default:
        return null;
    }
  }
}
