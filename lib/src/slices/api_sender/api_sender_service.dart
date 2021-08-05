import 'package:app/src/slices/api_message/model/api_message_fetched_model.dart';
import 'package:app/src/slices/api_sender/model/api_sender_model.dart';
import 'package:app/src/slices/api_sender/repository/api_sender_repository.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

class ApiSenderService {
  final ApiSenderRepository _repository;

  ApiSenderService({required Database database})
      : this._repository = ApiSenderRepository(database);

  Future<ApiSenderModel> createOrUpdate(
      ApiMessageFetchedModel fetchedModel) async {
    var senderData = fetchedModel.senderData;
    var sender = ApiSenderModel.fromMap(senderData);
    var getSender = await _repository.getByEmail(sender.email);
    if (getSender != null) {
      sender.senderId = getSender.senderId;
      if (sender.emailSince != null) {
        sender.emailSince = getSender.emailSince! < sender.emailSince!
            ? getSender.emailSince
            : sender.emailSince;
      }
      _repository.update(sender);
    }
    return _repository.insert(sender);
  }

  Future<List<ApiSenderModel>> getSendersForCards() async {
    List<List<String>> params = [
      ['unsubscribed', "=", 0.toString()],
      ['ignore_until', "<", (DateTime.now().millisecondsSinceEpoch).toString()]
    ];
    return await _repository.getByParams(params);
  }

  Future<ApiSenderModel?> getById(int? senderId) async {
    if (senderId == null) return null;
    var sender = await _repository.getById(senderId);
    return sender;
  }

  Future<void> markAsUnsubscribed(ApiSenderModel sender) async {
    sender.unsubscribed = 1;
    sender.ignoreUntil =
        (DateTime.now().add(Duration(days: 60)).millisecondsSinceEpoch).round();
    _repository.update(sender);
  }

  Future<void> markAsKeeped(ApiSenderModel sender) async {
    sender.unsubscribed = 0;
    sender.ignoreUntil =
        (DateTime.now().add(Duration(days: 60)).millisecondsSinceEpoch).round();
    _repository.update(sender);
  }
}
