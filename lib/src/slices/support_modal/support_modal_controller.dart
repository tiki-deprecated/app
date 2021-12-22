/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_zendesk/model/api_zendesk_article.dart';
import '../api_zendesk/model/api_zendesk_category.dart';
import '../api_zendesk/model/api_zendesk_section.dart';
import 'support_modal_service.dart';

class SupportModalController {
  final SupportModalService service;

  SupportModalController(this.service);

  void onBoxTap(dynamic boxData) {
    if (boxData is ApiZendeskCategory) service.getSectionsForCategory(boxData);
    if (boxData is ApiZendeskSection) service.getArticlesForSection(boxData);
    if (boxData is ApiZendeskArticle) service.getArticleById(boxData);
  }
}
