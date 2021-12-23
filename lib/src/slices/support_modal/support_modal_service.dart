/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import '../api_zendesk/api_zendesk_service.dart';
import '../api_zendesk/model/api_zendesk_article.dart';
import '../api_zendesk/model/api_zendesk_category.dart';
import '../api_zendesk/model/api_zendesk_section.dart';
import 'support_modal_controller.dart';
import 'support_modal_presenter.dart';

class SupportModalService extends ChangeNotifier {
  late final SupportModalPresenter presenter;
  late final SupportModalController controller;
  final ApiZendeskService zendeskService = ApiZendeskService();

  dynamic data;
  late ApiZendeskCategory? category;
  late ApiZendeskSection? section;
  late ApiZendeskArticle? article;


  SupportModalService() {
    this.presenter = SupportModalPresenter(this);
    this.controller = SupportModalController(this);
    getCategories();
  }

  Future<void> getCategories() async {
    this.data =
        await zendeskService.getZendeskCategories(includeSections: true);
    this.category = null;
    notifyListeners();
  }

  Future<void> getSectionsForCategory(ApiZendeskCategory category) async {
    this.data = await zendeskService.getZendeskSections(category.id,
        includeArticles: true);
    this.category = category;
    notifyListeners();
  }

  Future<void> getArticlesForSection(ApiZendeskSection section) async {
    this.data = await zendeskService.getZendeskArticles(section.id, category: section.category);
    this.section = section;
    this.article = null;
    notifyListeners();
  }

  Future<void> getArticleById(ApiZendeskArticle article) async {
    this.data = await zendeskService.getZendeskArticle(article.id,
      parentId: article.parentId,
      section: article.section,
      category: article.category
    );
    this.article = article;
    notifyListeners();
  }

}
