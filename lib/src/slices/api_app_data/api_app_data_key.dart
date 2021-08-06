/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

enum ApiAppDataKey {
  decisionCardsTestDone,
  fetchGmailLastRun,
  spamCardsLastRun,
}

extension ApiAppDataKeyExtension on ApiAppDataKey {
  String? get value {
    switch (this) {
      case ApiAppDataKey.decisionCardsTestDone:
        return 'decision cards test done';
      case ApiAppDataKey.fetchGmailLastRun:
        return 'fetchGoogleEmails last run';
      case ApiAppDataKey.spamCardsLastRun:
        return 'getDataForCards last run';
      default:
        return null;
    }
  }
}
