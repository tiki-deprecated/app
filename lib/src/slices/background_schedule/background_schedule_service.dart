import 'package:app/src/slices/api_company/api_company_service.dart';
import 'package:app/src/slices/api_company_index/api_company_index_service.dart';
import 'package:app/src/slices/api_google/api_google_service.dart';
import 'package:app/src/slices/api_message/api_email_service.dart';
import 'package:app/src/slices/api_message/model/api_message_fetched_model.dart';
import 'package:app/src/slices/api_sender/api_sender_service.dart';
import 'package:app/src/utils/api/helper_api_auth.dart';
import 'package:googleapis/gmail/v1.dart';

class BackgroundScheduleService {

  late HelperApiAuth helperApiAuth;

  BackgroundScheduleService(this.helperApiAuth);

  fetchGoogleEmails() async {
    var googleService = ApiGoogleService();
    var messagesMeta = await googleService.fetchGmailMessagesMetadata();
    List<Message> messages = [];
    for (var messageMeta in messagesMeta) {
      var message = await googleService.fetchAndProcessGmailMessage(
          messageMeta);
      if (message != null) messages.add(message);
    }
    for (var message in messages) {
      var fetchedModel = googleService.processEmailListMessage(message);
      var companyId = saveCompany(fetchedModel.domain);
      fetchedModel.senderData['company_id'] = companyId;
      var senderId = saveSender(fetchedModel);
      fetchedModel.senderData['sender_id'] = senderId;
      saveMessage(fetchedModel)
    }
  }

  saveCompany(String domain) async {
    var companyService = ApiCompanyService.auth(this.helperApiAuth);
    var companyId = await companyService.createOrUpdate(domain);
    return companyId;
  }

  saveSender(ApiMessageFetchedModel fetchedModel) {
    return ApiSenderService().createOrUpdate(fetchedModel);
  }

  saveMessage(ApiMessageFetchedModel fetchedModel) {
    return ApiMessageService().createOrUpdate(fetchedModel);
  }

}
