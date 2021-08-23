/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

enum ApiAppDataKey {
  decisionOverlayShown,
  gmailCategory,
  gmailLastFetch,
  gmailLastPage,
  googleOauthModalComplete,
  testCardsDone,
  userReferCode,
}

extension ApiAppDataKeyExtension on ApiAppDataKey {
  String? get value {
    switch (this) {
      case ApiAppDataKey.testCardsDone:
        return 'test_cards_done_bool';
      case ApiAppDataKey.gmailCategory:
        return 'gmail_category';
      case ApiAppDataKey.gmailLastFetch:
        return 'gmail_last_fetch_epoch';
      case ApiAppDataKey.gmailLastPage:
        return 'gmail_last_page';
      case ApiAppDataKey.googleOauthModalComplete:
        return 'google_oauth_modal_complete_bool';
      case ApiAppDataKey.decisionOverlayShown:
        return 'decision_overlay_shown_bool';
      case ApiAppDataKey.userReferCode:
        return 'user_refer_code';
      default:
        return null;
    }
  }
}
