import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
import 'package:app/src/slices/api_company/api_company_service.dart';
import 'package:app/src/slices/api_company/model/api_company_model.dart';
import 'package:app/src/slices/api_google/api_google_service.dart';
import 'package:app/src/slices/api_message/api_message_service.dart';
import 'package:app/src/slices/api_sender/api_sender_service.dart';
import 'package:app/src/slices/api_sender/model/api_sender_model.dart';
import 'package:app/src/slices/decision_card_spam/model/decision_card_spam_model.dart';

class ApiUnsubscribeSpamService {
  final ApiCompanyService apiCompanyService;
  final ApiMessageService apiMessageService;
  final ApiSenderService apiSenderService;
  final ApiGoogleService apiGoogleService;
  final ApiAppDataService apiAppDataService;

  ApiUnsubscribeSpamService(
      {required this.apiCompanyService,
      required this.apiSenderService,
      required this.apiMessageService,
      required this.apiGoogleService,
      required this.apiAppDataService});

  Future<List<DecisionCardSpamModel>?> getDataForCards() async {
    // TODO: uncomment to release
    // var lastRun =
    //     await ApiAppDataService().getByKey("getDataForCards last run");
    // if( lastRun != null && DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(lastRun.value))).inDays < 1 ) {
    //   print("lastRun getDataForCards: "+ DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(lastRun.value))).inMinutes.toString());
    //   return null;
    // }
    List<ApiSenderModel> senders = await apiSenderService.getSendersForCards();
    senders.removeWhere((element) => element.senderId == null);
    List<int> senderIds = senders.map((sender) => sender.senderId!).toList();
    Map<int, Map<String, dynamic>> messagesData =
        await apiMessageService.getMessageDataForCards(senderIds);
    List<DecisionCardSpamModel> dataModels = [];
    for (int i = 0; i < senders.length; i++) {
      var sender = senders[i];
      ApiCompanyModel? company =
          await apiCompanyService.getById(sender.companyId);
      dataModels.add(DecisionCardSpamModel(
          logoUrl: company?.logo,
          category: sender.category,
          companyName: sender.name,
          frequency: messagesData[sender.senderId]!['frequency'],
          openRate: messagesData[sender.senderId]!['openRate'],
          securityScore: company?.securityScore,
          sensitivityScore: company?.sensitivityScore,
          hackingScore: company?.breachScore,
          senderId: sender.senderId!));
    }
    apiAppDataService.save("getDataForCards last run",
        DateTime.now().millisecondsSinceEpoch.toString());
    return dataModels;
  }

  void unsubscribe(int senderId) async {
    ApiSenderModel? sender = await apiSenderService.getById(senderId);
    if (sender != null) {
      String? mailTo = sender.unsubscribeMailTo;
      if (mailTo != null) {
        var unsubscribed = await apiGoogleService.sendUnsubscribeMail(mailTo);
        if (unsubscribed) apiSenderService.markAsUnsubscribed(sender);
      }
    }
  }

  void keepReceiving(int senderId) async {
    ApiSenderModel? sender = await apiSenderService.getById(senderId);
    if (sender != null) {
      apiSenderService.markAsKeeped(sender);
    }
  }
}
