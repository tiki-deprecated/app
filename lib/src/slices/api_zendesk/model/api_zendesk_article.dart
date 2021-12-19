class ApiZendeskArticle {
  late num id;
  late String title;
  late String category;
  late String section;
  late String content;
  late DateTime updatedAt;

  ApiZendeskArticle.fromMap(Map map){
    this.id = map['id'];
    this.title = map['title'];
    this.content = map['content'];
    this.updatedAt = map['updatedAt'];
  }
}
