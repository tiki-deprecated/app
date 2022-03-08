import 'package:decision_sdk/decision.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../../../config/config_color.dart';
import '../../../widgets/header_bar/header_bar.dart';
import '../../api_email_msg/api_email_msg_service.dart';
import '../../api_email_msg/model/api_email_msg_model.dart';
import '../../api_email_sender/api_email_sender_service.dart';
import '../../api_email_sender/model/api_email_sender_model.dart';
import '../../api_oauth/api_oauth_service.dart';
import '../../api_oauth/model/api_oauth_model_account.dart';
import '../../data_fetch/data_fetch_service.dart';

class HomeScreenDecisionContainer extends StatelessWidget {
  final Logger _log = Logger('HomeScreenDecisionContainer');

  late final ApiEmailSenderService apiEmailSenderService;
  late final ApiEmailMsgService apiEmailMsgService;
  late final DataFetchService dataFetchService;
  late final DecisionSdk decisionSdk;
  late final ApiOAuthService apiAuthService;

  HomeScreenDecisionContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    apiEmailSenderService = Provider.of<ApiEmailSenderService>(context);
    apiEmailMsgService = Provider.of<ApiEmailMsgService>(context);
    dataFetchService = Provider.of<DataFetchService>(context);
    decisionSdk = Provider.of<DecisionSdk>(context);
    apiAuthService = Provider.of<ApiOAuthService>(context);
    _getCards();
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ConfigColor.greyOne),
      SafeArea(
          child: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Column(children: [
                HeaderBar(),
                Expanded(child: decisionSdk.home())])))])));
  }

  Future<void> _getCards() async {
    String? provider = (await apiAuthService.getAccount())?.provider;
    if(provider != null) {
      List<ApiEmailSenderModel> senders =
          await apiEmailSenderService.getUnsubscribed();
      Map<String, List<ApiEmailMsgModel>> messages =
          await apiEmailMsgService.getBySenders(senders);
      for (ApiEmailSenderModel sender in senders) {
        List<ApiEmailMsgModel>? msgs = messages[sender.email!];
        if (msgs != null && msgs.isNotEmpty) {
          decisionSdk.addSpamCards(
              messages: msgs,
              provider: provider,
              unsubscribeCallback: _unsubscribeCallback,
              keepCallback: _keepCallback);
        }
      }
    }
  }

  _unsubscribeCallback(int senderId) async {
      ApiEmailSenderModel? sender = await apiEmailSenderService.getById(senderId);
      if (sender != null) {
        try {
          ApiOAuthModelAccount account = (await apiAuthService.getAccount())!;
          String? mailTo = sender.unsubscribeMailTo;
          if (mailTo != null) {
            String list = sender.name ?? sender.email!;
            dataFetchService.email.unsubscribe(account, mailTo, list).then(
                    (success) => _log.finest(
                    mailTo + ' unsubscribed status: ' + success.toString()));
            await apiEmailSenderService.markAsUnsubscribed(sender);
          }
        } catch (e) {
          _log.warning(
              'Failed to unsubscribe from: ' + sender.unsubscribeMailTo!, e);
        }
      }
    }

  _keepCallback(int senderId) async {
      ApiEmailSenderModel? sender =
      await apiEmailSenderService.getById(senderId);
      if (sender != null) {
        await apiEmailSenderService.markAsKept(sender);
      }
  }
}
