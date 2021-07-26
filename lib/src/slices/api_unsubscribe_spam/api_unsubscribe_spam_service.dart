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

  ApiUnsubscribeSpamService(
      {required this.apiCompanyService,
      required this.apiSenderService,
      required this.apiMessageService,
      required this.apiGoogleService});

  Future<List<DecisionCardSpamModel>> getDataForCards() async {
    List<ApiSenderModel> senders = await apiSenderService.getSendersForCards();
    senders.removeWhere((element) => element.senderId == null);
    List<int> senderIds = senders.map((sender) => sender.senderId!).toList();
    var messagesData = apiMessageService.getMessageDataForCards(senderIds);
    List<DecisionCardSpamModel> dataModels = [];
    for (int i = 0; i < senders.length; i++) {
      var sender = senders[i];
      ApiCompanyModel company =
          await apiCompanyService.getById(sender.companyId);
      dataModels.add(DecisionCardSpamModel(
          logoUrl: company.logo,
          category: sender.category,
          companyName: sender.name,
          frequency: messagesData['frequency'],
          openRate: messagesData['openRate'],
          securityScore: company.securityScore,
          sensitivityScore: company.sensitivityScore,
          hackingScore: company.breachScore,
          senderId: sender.senderId!));
    }
    return dataModels;
  }

  void unsubscribe(int senderId) async {
    ApiSenderModel sender = await apiSenderService.getById(senderId);
    String? mailTo = sender.unsubscribeMailTo;
    if (mailTo != null) {
      var unsubscribed = await apiGoogleService.sendUnsubscribeMail(mailTo);
      if (unsubscribed) apiSenderService.markAsUnsubscribed(sender);
    }
  }

  void keepReceiving(int senderId) async {
    ApiSenderModel sender = await apiSenderService.getById(senderId);
    apiSenderService.markAsKeeped(sender);
  }
}
