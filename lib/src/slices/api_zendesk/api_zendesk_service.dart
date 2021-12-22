import 'package:flutter/services.dart';

import 'model/api_zendesk_article.dart';
import 'model/api_zendesk_category.dart';
import 'model/api_zendesk_section.dart';

class ApiZendeskService {
  static const _platform = MethodChannel('com.mytiki.app');

  Future<List<ApiZendeskCategory>> getZendeskCategories(
      {bool includeSections = false}) async {
    List apiCats = await _platform.invokeMethod("getZendeskCategories");
    List<ApiZendeskCategory> cats =
        apiCats.map((e) => ApiZendeskCategory.fromMap(e)).toList();
    if (includeSections) {
      for (int i = 0; i < cats.length; i++) {
        ApiZendeskCategory category = cats[i];
        category.sections = await getZendeskSectionsForCategory(category);
      }
    }
    return cats;
  }

  Future<List<ApiZendeskSection>> getZendeskSectionsForCategory(
      ApiZendeskCategory category) async {
    return (await getZendeskSections(category.id)).map((section) {
      section.category = category.title;
      return section;
    }).toList();
  }

  Future<List<ApiZendeskSection>> getZendeskSections(num categoryId,
      {bool includeArticles = false}) async {
    List apiSections = await _platform
        .invokeMethod("getZendeskSections", {"categoryId": categoryId});
    List<ApiZendeskSection> sections =
        apiSections.map((e) => ApiZendeskSection.fromMap(e)).toList();
    if (includeArticles) {
      for (int i = 0; i < sections.length; i++) {
        ApiZendeskSection section = sections[i];
        section.articles = await getZendeskArticles(section.id);
      }
    }
    return sections;
  }

  Future<List<ApiZendeskArticle>> getZendeskArticlesForSection(
      ApiZendeskSection section) async {
    return (await getZendeskArticles(section.id)).map((article) {
      article.category = section.category;
      article.section = section.title;
      return article;
    }).toList();
  }

  Future<List<ApiZendeskArticle>> getZendeskArticles(num sectionId,
      {bool includeContent = false}) async {
    List apiArticles = await _platform
        .invokeMethod("getZendeskArticles", {"sectionId": sectionId});
    List<ApiZendeskArticle> articles =
        apiArticles.map((e) => ApiZendeskArticle.fromMap(e)).toList();
    return articles;
  }

  Future<ApiZendeskArticle> getZendeskArticle(num articleId) async {
    ApiZendeskArticle article = ApiZendeskArticle.fromMap(await _platform
        .invokeMethod("getZendeskArticle", {"articleId": articleId}));
    return article;
  }
}
