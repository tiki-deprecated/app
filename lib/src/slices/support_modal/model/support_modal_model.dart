import '../../api_zendesk/model/api_zendesk_article.dart';
import '../../api_zendesk/model/api_zendesk_category.dart';
import '../../api_zendesk/model/api_zendesk_section.dart';

class SupportModalModel {
  dynamic data;
  late ApiZendeskCategory? category;
  late ApiZendeskSection? section;
  late ApiZendeskArticle? article;
}
