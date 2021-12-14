import 'package:flutter/services.dart';

class ApiZendeskService{
  static const _platform = MethodChannel('com.mytiki.app');

  Future getZendeskCategories() async =>
      await _platform.invokeMethod("getZendeskCategories");

  Future getZendeskSections(num categoryId) async =>
      await _platform.invokeMethod("getZendeskSections", {"categoryId": categoryId});

  Future getZendeskArticles(num sectionId) async =>
      await _platform.invokeMethod("getZendeskArticles", {"sectionId": sectionId});

  Future getZendeskArticle(num articleId) async =>
      await _platform.invokeMethod("getZendeskArticle", {"articleId": articleId});
}