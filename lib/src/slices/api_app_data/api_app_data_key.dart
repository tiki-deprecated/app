/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

enum ApiAppDataKey {
  emailIndexEpoch,
  emailIndexLabel,
  emailIndexPage,
  testCardsDone,
  userReferCode,
  decisionOverlayShown,
}

extension ApiAppDataKeyExtension on ApiAppDataKey {
  String? get value {
    switch (this) {
      case ApiAppDataKey.emailIndexEpoch:
        return 'email_index_epoch';
      case ApiAppDataKey.emailIndexLabel:
        return 'email_index_label';
      case ApiAppDataKey.emailIndexPage:
        return 'email_index_page';
      case ApiAppDataKey.testCardsDone:
        return 'test_cards_done_bool';
      case ApiAppDataKey.decisionOverlayShown:
        return 'decision_overlay_shown_bool';
      case ApiAppDataKey.userReferCode:
        return 'user_refer_code';
      default:
        return null;
    }
  }
}
