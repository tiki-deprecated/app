class ApiSenderModel {
  int? senderId;
  int? companyId;
  final String name;
  final String email;
  final String category;
  String? unsubscribeMailTo;

  ApiSenderModel(
      {this.senderId,
      this.companyId,
      required this.name,
      required this.email,
      required this.category,
      this.unsubscribeMailTo});

  ApiSenderModel.fromMap(senderMap)
      : senderId = senderMap['sender_id'],
        companyId = senderMap['company_id'],
        name = senderMap['name'],
        email = senderMap['email'],
        category = senderMap['category'],
        unsubscribeMailTo = senderMap['unsubscribe_mail_to'];

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'company_id': companyId,
      'name': name,
      'email': email,
      'category': category,
      'unsubscribe_mail_to': unsubscribeMailTo,
    };
  }

  @override
  String toString() {
    var str = '''SenderModel{ 
    senderId : $senderId, 
    companyId : $companyId, 
    name : $name, 
    email : $email,
    category : $category,
    unsubscribeMailTo : $unsubscribeMailTo,}''';
    return str;
  }
}
