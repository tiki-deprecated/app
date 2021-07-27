import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
import 'package:app/src/slices/api_company/api_company_service.dart';
import 'package:app/src/slices/api_company/model/api_company_model.dart';
import 'package:app/src/slices/api_google/api_google_service.dart';
import 'package:app/src/slices/api_message/api_message_service.dart';
import 'package:app/src/slices/api_message/model/api_message_fetched_model.dart';
import 'package:app/src/slices/api_message/model/api_message_model.dart';
import 'package:app/src/slices/api_sender/api_sender_service.dart';
import 'package:app/src/slices/api_sender/model/api_sender_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:provider/provider.dart';

class BackgroundScheduleService {
  final BuildContext context;

  BackgroundScheduleService(this.context);

  Future<void> fetchGoogleEmails() async {
    ApiAppDataService apiAppDataService =
        Provider.of<ApiAppDataService>(context, listen: false);
    print("start - " + DateTime.now().minute.toString());
    var lastRun =
        await apiAppDataService.getByKey("fetchGoogleEmails last run");
    if (lastRun != null &&
        DateTime.now()
                .difference(DateTime.fromMillisecondsSinceEpoch(
                    int.parse(lastRun.value)))
                .inDays <
            1) {
      print("lastRun fetchGoogleEmails: " +
          DateTime.now()
              .difference(
                  DateTime.fromMillisecondsSinceEpoch(int.parse(lastRun.value)))
              .inMinutes
              .toString());
      return null;
    }
    var googleService = Provider.of<ApiGoogleService>(context, listen: false);
    if (await googleService.isConnected()) {
      var messagesMeta = await googleService.fetchGmailMessagesMetadata();
      List<Message> messages = [];
      if (messagesMeta != null) {
        for (var messageMeta in messagesMeta) {
          var message =
              await googleService.fetchAndProcessGmailMessage(messageMeta);
          if (message != null) messages.add(message);
        }
      }
      for (var message in messages) {
        var fetchedModel = googleService.processEmailListMessage(message);
        var company = await saveCompany(fetchedModel.domain);
        fetchedModel.senderData['company_id'] = company?.companyId.toString();
        var sender = await saveSender(fetchedModel);
        fetchedModel.senderData['sender_id'] = sender.senderId.toString();
        saveMessage(fetchedModel);
      }
    }
    ApiAppDataService().save("fetchGoogleEmails last run",
        DateTime.now().millisecondsSinceEpoch.toString());
    print("end - " + DateTime.now().minute.toString());
  }

  Future<ApiCompanyModel?> saveCompany(String? domain) async {
    if (domain == null) return null;
    var companyService = Provider.of<ApiCompanyService>(context, listen: false);
    var company = await companyService.createOrUpdate(domain);
    return company;
  }

  Future<ApiSenderModel> saveSender(ApiMessageFetchedModel fetchedModel) async {
    var senderService = Provider.of<ApiSenderService>(context, listen: false);
    var sender = await senderService.createOrUpdate(fetchedModel);
    return sender;
  }

  Future<ApiMessageModel> saveMessage(ApiMessageFetchedModel fetchedModel) async {
    var messageService = Provider.of<ApiMessageService>(context, listen: false);
    var message = await messageService.save(fetchedModel);
    return message;
  }
}
