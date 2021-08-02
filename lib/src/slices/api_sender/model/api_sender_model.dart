class ApiSenderModel {
  int? senderId;
  int? companyId;
  final String name;
  final String email;
  final String category;
  String? unsubscribeMailTo;
  int? emailSince;
  int unsubscribed;
  int ignoreUntil = 0;

  ApiSenderModel(
      {this.senderId,
      this.companyId,
      required this.name,
      required this.email,
      required this.category,
      this.unsubscribeMailTo,
      this.emailSince,
      this.ignoreUntil = 0,
      this.unsubscribed = 0});

  ApiSenderModel.fromMap(senderMap)
      : senderId = senderMap['sender_id'],
        companyId = senderMap['company_id'] is String
            ? num.parse(senderMap['company_id'])
            : senderMap['company_id'],
        name = senderMap['name'].toString(),
        email = senderMap['email'].toString(),
        category = senderMap['category'].toString(),
        unsubscribeMailTo = senderMap['unsubscribe_mail_to'].toString(),
        emailSince = senderMap['email_since'] != null
            ? int.parse(senderMap['email_since'].toString())
            : (DateTime.now().millisecondsSinceEpoch).round(),
        ignoreUntil = senderMap['ignore_until'] ?? 0,
        unsubscribed = senderMap['unsubscribed'] ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'company_id': companyId,
      'name': name,
      'email': email,
      'category': category,
      'unsubscribe_mail_to': unsubscribeMailTo,
      'email_since': emailSince,
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
    email_since : $emailSince,
    ignoreUntil : $ignoreUntil,
    unsubscribed : $unsubscribed}''';
    return str;
  }
}
