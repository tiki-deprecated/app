class ApiMessageFetchedModel {
  final senderData;
  final messageExtId;
  final messageReceivedDate;
  final messageOpenedDate;
  final account;
  final domain;

  ApiMessageFetchedModel({
    this.senderData,
    this.messageExtId,
    this.messageReceivedDate,
    this.messageOpenedDate,
    this.account,
    this.domain,
  });
}
