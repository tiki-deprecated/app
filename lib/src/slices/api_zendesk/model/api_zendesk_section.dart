import 'api_zendesk_article.dart';

class ApiZendeskSection {
  late int id;
  late String title;
  late String category;
  late String content;
  late List<ApiZendeskArticle> articles;

  ApiZendeskSection.fromMap(Map map){
    this.id = map['id'];
    this.title = map['title'];
    this.content = map['description'];
    this.category = map['category'] ?? '';
    this.articles = map['sections'] ?? [];
  }
}
