class ApiMessageModel {
  final int messageId;
  final int extMessageId;
  final int senderId;
  final int receivedDate;
  int? openedDate;
  final String account;

  ApiMessageModel({
    required this.messageId,
    required this.extMessageId,
    required this.senderId,
    required this.receivedDate,
    this.openedDate,
    required this.account,
  });
}
