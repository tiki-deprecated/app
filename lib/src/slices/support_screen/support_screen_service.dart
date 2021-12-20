/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_zendesk/model/api_zendesk_article.dart';
import 'package:app/src/slices/api_zendesk/model/api_zendesk_category.dart';
import 'package:app/src/slices/api_zendesk/model/api_zendesk_section.dart';

import '../api_zendesk/api_zendesk_service.dart';
import 'package:flutter/widgets.dart';

import 'support_screen_controller.dart';
import 'support_screen_presenter.dart';

class SupportScreenService extends ChangeNotifier {
  late final SupportScreenPresenter presenter;
  late final SupportScreenController controller;
  late final ApiZendeskService zendeskService = ApiZendeskService();
  dynamic data = <ApiZendeskCategory> [
    ApiZendeskCategory.fromMap(
        {"id": 1, "title": "Title 1", "content" : "This is a test category"}),

    ApiZendeskCategory.fromMap(
        {"id": 2, "title": "Title 2", "content" : "This is a test category"}),

    ApiZendeskCategory.fromMap(
        {"id": 3, "title": "Title 3", "content" : "This is a test category"}),

    ApiZendeskCategory.fromMap(
        {"id": 4, "title": "Title 4", "content" : "This is a test category"}),

    ApiZendeskCategory.fromMap(
        {"id": 5, "title": "Title 5", "content" : "This is a test category"})
  ];

  SupportScreenService() {
    this.presenter = SupportScreenPresenter(this);
    this.controller = SupportScreenController(this);
    getCategories();
  }

  Future<void> getCategories() async {
    this.data = <ApiZendeskCategory> [
      ApiZendeskCategory.fromMap(
          {"id": 1, "title": "Title 1", "content" : "This is a test category"}),

      ApiZendeskCategory.fromMap(
          {"id": 2, "title": "Title 2", "content" : "This is a test category"}),

      ApiZendeskCategory.fromMap(
          {"id": 3, "title": "Title 3", "content" : "This is a test category"}),

      ApiZendeskCategory.fromMap(
          {"id": 4, "title": "Title 4", "content" : "This is a test category"}),

      ApiZendeskCategory.fromMap(
          {"id": 5, "title": "Title 5", "content" : "This is a test category"})
    ];
  }

  Future<void> getSections(num id) async {
    this.data = [
      ApiZendeskSection.fromMap(
          {"id": 1, "title": "Title 1", "content" : "This is a test Section"}),

      ApiZendeskSection.fromMap(
        {"id": 2, "title": "Title 2", "content" : "This is a test Section"}),

      ApiZendeskSection.fromMap(
        {"id": 3, "title": "Title 3", "content" : "This is a test Section"}),

      ApiZendeskSection.fromMap(
        {"id": 4, "title": "Title 4", "content" : "This is a test Section"}),

      ApiZendeskSection.fromMap(
        {"id": 5, "title": "Title 5", "content" : "This is a test Section"})
    ];
  }

  Future<void> getArticles(num id) async {
    this.data = [
      ApiZendeskArticle.fromMap(
          {"id": 1, "title": "Title 1", "content" : "This is a test Article"}),

      ApiZendeskArticle.fromMap(
          {"id": 2, "title": "Title 2", "content" : "This is a test Article"}),

      ApiZendeskArticle.fromMap(
          {"id": 3, "title": "Title 3", "content" : "This is a test Article"}),

      ApiZendeskArticle.fromMap(
          {"id": 4, "title": "Title 4", "content" : "This is a test Article"}),

      ApiZendeskArticle.fromMap(
          {"id": 5, "title": "Title 5", "content" : "This is a test Article"})
    ];
  }

  Future<void> getArticle(num id) async {
    this.data = ApiZendeskArticle.fromMap(
        {"id": 5, "title": "Title 5", "content" : "This is a test Article"});
  }

  void update() {
    notifyListeners();
  }
}
