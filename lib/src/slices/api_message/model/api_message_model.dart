import 'package:app/src/slices/api_message/model/api_message_fetched_model.dart';

class ApiMessageModel {
  int? messageId;
  String? extMessageId;
  int? senderId;
  int? receivedDate;
  int? openedDate;
  String? account;

  ApiMessageModel({
    this.messageId,
    this.extMessageId,
    this.senderId,
    this.receivedDate,
    this.openedDate,
    this.account,
  });

  ApiMessageModel.fromFetchedMessage(ApiMessageFetchedModel fetchedModel)
      : extMessageId = fetchedModel.messageExtId,
        senderId = fetchedModel.senderData['sender_id'] is String
            ? int.parse(fetchedModel.senderData['sender_id'])
            : fetchedModel.senderData['sender_id'],
        receivedDate = fetchedModel.messageReceivedDate is String
            ? int.parse(fetchedModel.messageReceivedDate)
            : fetchedModel.messageReceivedDate,
        openedDate = fetchedModel.messageOpenedDate,
        account = fetchedModel.account;

  ApiMessageModel.fromMap(Map<String, dynamic> map)
      : messageId = map['message_id'],
        extMessageId = map['ext_message_id'],
        senderId = map['sender_id'],
        receivedDate = map['received_date'],
        openedDate = map['opened_date'],
        account = map['account'];

  Map<String, dynamic> toMap() {
    return {
      'message_id': messageId,
      'ext_message_id': extMessageId,
      'sender_id': senderId,
      'received_date': receivedDate,
      'opened_date': openedDate,
      'account': account,
    };
  }

  @override
  String toString() {
    var str = '''MessageModel{ 
      messageId : $messageId,
      extMessageId : $extMessageId,
      senderId : $senderId,
      receivedDate : $receivedDate,
      openedDate : $openedDate,
      account : $account}''';
    return str;
  }
}
