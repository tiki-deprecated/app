import 'package:app/src/slices/api_message/model/api_message_fetched_model.dart';
import 'package:app/src/slices/api_sender/model/api_sender_model.dart';
import 'package:app/src/slices/api_sender/repository/api_sender_repository.dart';

class ApiSenderService {
  final ApiSenderRepository repository;

  ApiSenderService() : this.repository = ApiSenderRepository();

  Future<ApiSenderModel> createOrUpdate(
      ApiMessageFetchedModel fetchedModel) async {
    var senderData = fetchedModel.senderData;
    var sender = ApiSenderModel.fromMap(senderData);
    var getSender = await ApiSenderRepository().get(sender);
    var dbCompany = getSender.length > 0
        ? ApiSenderRepository().update(sender)
        : ApiSenderRepository().insert(sender);
    return dbCompany;
  }

  Future<List<ApiSenderModel>> getSendersForCards() async {
    List<List<String>> params = [
      ['unsubscribed', "=", 0.toString()],
      [
        'ignore_until',
        "<",
        (DateTime.now().millisecondsSinceEpoch / 1000).toString()
      ]
    ];
    return await repository.getByParams(params);
  }

  Future<ApiSenderModel?> getById(int? senderId) async {
    if (senderId == null) return null;
    var sender = await ApiSenderRepository().getById(senderId);
    return sender;
  }

  Future<void> markAsUnsubscribed(ApiSenderModel sender) async {
    sender.unsubscribed = 1;
    sender.ignoreUntil =
        (DateTime.now().add(Duration(days: 60)).millisecondsSinceEpoch / 1000)
            .round();
    ApiSenderRepository().update(sender);
  }

  Future<void> markAsKeeped(ApiSenderModel sender) async {
    sender.unsubscribed = 0;
    sender.ignoreUntil =
        (DateTime.now().add(Duration(days: 60)).millisecondsSinceEpoch / 1000)
            .round();
    ApiSenderRepository().update(sender);
  }
}
