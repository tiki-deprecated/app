import 'api_zendesk_section.dart';

class ApiZendeskCategory {
  late num id;
  late String title;
  late String content;
  late List<ApiZendeskSection> sections;

  ApiZendeskCategory.fromMap(Map map) {
    this.id = map['id'];
    this.title = map['title'];
    this.content = map['description'];
    this.sections = map['sections'] ?? <ApiZendeskSection>[];
  }
}
