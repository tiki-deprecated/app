class ApiSenderModel {
  int? senderId;
  int? companyId;
  final String name;
  final String email;
  final String category;
  String? unsubscribeMailTo;
  int unsubscribed;
  int ignoreUntil = 0;

  ApiSenderModel(
      {this.senderId,
      this.companyId,
      required this.name,
      required this.email,
      required this.category,
      this.unsubscribeMailTo,
      this.ignoreUntil = 0,
      this.unsubscribed = 0});

  ApiSenderModel.fromMap(senderMap)
      : senderId = senderMap['sender_id'],
        companyId = int.parse(senderMap['company_id']),
        name = senderMap['name'].toString(),
        email = senderMap['email'].toString(),
        category = senderMap['category'].toString(),
        unsubscribeMailTo = senderMap['unsubscribe_mail_to'].toString(),
        ignoreUntil = senderMap['ignore_until'],
        unsubscribed = senderMap['unsubscribed'];

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'company_id': companyId,
      'name': name,
      'email': email,
      'category': category,
      'unsubscribe_mail_to': unsubscribeMailTo,
      'ignore_until': ignoreUntil,
      'unsubscribed': unsubscribed,
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
    unsubscribeMailTo : $unsubscribeMailTo,
    ignoreUntil : $ignoreUntil,
    unsubscribed : $unsubscribed}''';
    return str;
  }
}
