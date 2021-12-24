/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

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

  navigateBack(BuildContext context) {
    if (service.data is List<ApiZendeskSection>) service.getCategories();
    if (service.data is List<ApiZendeskArticle>)
      service.getSectionsForCategory(service.category!);
    if (service.data is ApiZendeskArticle)
      service.getArticlesForSection(service.section!);
  }

  Future<void> launchUrl(String url, BuildContext context) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
