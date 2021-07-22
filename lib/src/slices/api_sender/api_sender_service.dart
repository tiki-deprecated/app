import 'package:app/src/slices/api_message/model/api_message_fetched_model.dart';
import 'package:app/src/slices/api_sender/model/api_sender_model.dart';
import 'package:app/src/slices/api_sender/repository/api_sender_repository.dart';

class ApiSenderService {
  Future<ApiSenderModel> createOrUpdate(
      ApiMessageFetchedModel fetchedModel) async {
    var sender = ApiSenderModel.fromMap(fetchedModel.senderData);
    var getSender = await ApiSenderRepository().get(sender);
    var dbCompany = getSender.length > 0
        ? ApiSenderRepository().update(sender)
        : ApiSenderRepository().insert(sender);
    return dbCompany;
  }
}
