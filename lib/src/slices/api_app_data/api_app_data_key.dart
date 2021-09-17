/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

enum ApiAppDataKey {
  decisionOverlayShown,
  gmailCategory,
  bkgSvEmailLastFetch,
  gmailPage,
  googleOauthModalComplete,
  testCardsDone,
  userReferCode,
  dataBkgLastAccount
}

extension ApiAppDataKeyExtension on ApiAppDataKey {
  String? get value {
    switch (this) {
      case ApiAppDataKey.testCardsDone:
        return 'test_cards_done_bool';
      case ApiAppDataKey.gmailCategory:
        return 'gmail_category';
      case ApiAppDataKey.bkgSvEmailLastFetch:
        return 'background_service_email_last_fetch';
      case ApiAppDataKey.gmailPage:
        return 'gmail_last_page';
      case ApiAppDataKey.googleOauthModalComplete:
        return 'google_oauth_modal_complete_bool';
      case ApiAppDataKey.decisionOverlayShown:
        return 'decision_overlay_shown_bool';
      case ApiAppDataKey.userReferCode:
        return 'user_refer_code';
      case ApiAppDataKey.dataBkgLastAccount:
        return 'data_background_last_account';
      default:
        return null;
    }
  }
}
