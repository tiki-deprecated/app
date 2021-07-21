class ApiSenderModel {
  final int senderId;
  final int companyId;
  final String name;
  final String email;
  final String category;
  final int unsubscribeMailTo;

  ApiSenderModel(
      {required this.senderId,
      required this.companyId,
      required this.name,
      required this.email,
      required this.category,
      required this.unsubscribeMailTo});
}
