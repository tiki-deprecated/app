/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_zendesk/api_zendesk_service.dart';
import 'package:flutter/widgets.dart';

import 'support_screen_controller.dart';
import 'support_screen_presenter.dart';

class SupportScreenService extends ChangeNotifier {
  late final SupportScreenPresenter presenter;
  late final SupportScreenController controller;
  late final ApiZendeskService zendeskService = ApiZendeskService();
  dynamic data;

  SupportScreenService() {
    this.presenter = SupportScreenPresenter(this);
    this.controller = SupportScreenController(this);
  }

  Future<void> getCategories() async {
    this.data = zendeskService.getZendeskCategories();
    notifyListeners();
  }

  Future<void> getSections(num id) async {
    this.data = zendeskService.getZendeskSections(id);
  }

  Future<void> getArticles(num id) async {
    this.data = zendeskService.getZendeskArticle(id);
  }

  Future<void> getArticle(num id) async {
    this.data = zendeskService.getZendeskArticle(id);
  }

  void update() {
    notifyListeners();
  }
}
