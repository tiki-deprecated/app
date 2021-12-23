import 'package:intl/intl.dart';

class ApiZendeskArticle {
  late num id;
  late num parentId;
  late String title;
  late String category;
  late String section;
  late String content;
  late DateTime? updatedAt;

  ApiZendeskArticle.fromMap(Map map) {
    this.id = map['id'];
    this.title = map['title'];
    this.content = map['content'] ?? '';
    this.section = map['section'] ?? '';
    this.category = map['category'] ?? '';
    this.updatedAt = map['updatedAt'] != null
        ? DateFormat("EEE MMM dd HH:mm:ss yyyy")
            .parse(map['updatedAt'].replaceRange(20, 30, ''))
        : null;
  }
}
