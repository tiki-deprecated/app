import 'package:app/src/slices/api_message/model/api_message_fetched_model.dart';
import 'package:app/src/slices/api_message/model/api_message_model.dart';
import 'package:app/src/slices/api_message/repository/api_message_repository.dart';

class ApiMessageService {
  save(ApiMessageFetchedModel fetchedModel) async {
    var message = ApiMessageModel.fromFetchedMessage(fetchedModel);
    var getMessage = await ApiMessageRepository().get(message);
    if (getMessage.length == 0) return ApiMessageRepository().insert(message);
  }
}
