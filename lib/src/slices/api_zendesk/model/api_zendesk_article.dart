import 'dart:io';

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
    this.updatedAt =
        map['updatedAt'] != null ? formatDate(map['updatedAt']) : null;
  }

  DateTime formatDate(String date) {
    if (Platform.isAndroid) {
      date = date.replaceRange(20, 30, '');
    }
    return DateFormat("EEE MMM dd HH:mm:ss yyyy").parse(date);
  }
}
