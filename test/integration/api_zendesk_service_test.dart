import 'package:app/src/slices/api_zendesk/api_zendesk_service.dart';
import 'package:app/src/slices/api_zendesk/model/api_zendesk_article.dart';
import 'package:app/src/slices/api_zendesk/model/api_zendesk_category.dart';
import 'package:app/src/slices/api_zendesk/model/api_zendesk_section.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart' as app;

import '../mock_firebase.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets("test Zendesk get category -> section -> article", (WidgetTester tester) async {
    app.main();
    expect(1, 1);
    await tester.pumpAndSettle();
    ApiZendeskService apiZendeskService = ApiZendeskService();
    List<ApiZendeskCategory> categories = await apiZendeskService.getZendeskCategories();
    expect(categories.length > 0, true);
    ApiZendeskCategory firstCategory = categories[0];
    List<ApiZendeskSection> sections = await apiZendeskService.getZendeskSections(firstCategory.id);
    expect(sections.length > 0, true);
    ApiZendeskSection firstSection = sections[0];
    List<ApiZendeskArticle> articles = await apiZendeskService.getZendeskArticles(firstSection.id);
    expect(articles.length > 0, true);
    ApiZendeskArticle firstArticle = articles[0];
    ApiZendeskArticle article = await apiZendeskService.getZendeskArticle(firstArticle.id);
    expect(article.id > 0, true);
  });

}