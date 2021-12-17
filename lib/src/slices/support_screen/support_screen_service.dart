/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_zendesk/api_zendesk_service.dart';
import '../api_zendesk/model/api_zendesk_category.dart';
import 'package:flutter/widgets.dart';

import 'model/support_screen_model.dart';
import 'model/support_screen_type.dart';
import 'support_screen_controller.dart';
import 'support_screen_presenter.dart';

class SupportScreenService extends ChangeNotifier {
  late final SupportScreenPresenter presenter;
  late final SupportScreenController controller;
  late final SupportScreenModel model;
  late final ApiZendeskService zendeskService = ApiZendeskService();

  SupportScreenService() {
    this.presenter = SupportScreenPresenter(this);
    this.controller = SupportScreenController(this);
    this.model = SupportScreenModel();
  }

  Future<void> getData() async{
    switch(this.model.type){
      case SupportScreenType.category:
        await getSections(this.model.id);
        break;
      case SupportScreenType.section:
        await getArticles(this.model.id);
        break;
      case SupportScreenType.article:
        await getArticle(this.model.id);
        break;
    }
    notifyListeners();
  }

  num getArticlesCount(ApiZendeskCategory category) {
    return zendeskService.getZendeskArticlesCount(category);
  }

  Future<void> getSections(String id) async {
    this.model.data = await zendeskService.getZendeskSections(num.parse(id));
    this.model.type = SupportScreenType.section;
    this.model.name = "All categories";
  }

  Future<void> getArticles(String id) async {}

  Future<void> getArticle(String id) async {}
}