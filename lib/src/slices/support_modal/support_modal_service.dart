/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import '../api_zendesk/api_zendesk_service.dart';
import '../api_zendesk/model/api_zendesk_article.dart';
import '../api_zendesk/model/api_zendesk_category.dart';
import '../api_zendesk/model/api_zendesk_section.dart';
import 'model/support_modal_model.dart';
import 'support_modal_controller.dart';
import 'support_modal_presenter.dart';

class SupportModalService extends ChangeNotifier {
  late final SupportModalPresenter presenter;
  late final SupportModalController controller;
  late final SupportModalModel model;
  final ApiZendeskService zendeskService = ApiZendeskService();

  SupportModalService() {
    this.presenter = SupportModalPresenter(this);
    this.controller = SupportModalController(this);
    this.model = SupportModalModel();
    getCategories();
  }

  Future<void> getCategories() async {
    this.model.data =
        await zendeskService.getZendeskCategories(includeSections: true);
    this.model.category = null;
    notifyListeners();
  }

  Future<void> getSectionsForCategory(ApiZendeskCategory category) async {
    this.model.data = await zendeskService.getZendeskSections(category.id,
        includeArticles: true);
    this.model.category = category;
    notifyListeners();
  }

  Future<void> getArticlesForSection(ApiZendeskSection section) async {
    this.model.data = await zendeskService.getZendeskArticles(section.id,
        category: section.category);
    this.model.section = section;
    this.model.article = null;
    notifyListeners();
  }

  Future<void> getArticleById(ApiZendeskArticle article) async {
    this.model.data = await zendeskService.getZendeskArticle(article.id,
        section: article.section, category: article.category);
    this.model.article = article;
    notifyListeners();
  }
}
