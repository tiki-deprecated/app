import 'package:decision_sdk/decision.dart';
import 'package:flutter/material.dart';

import '../../../config/config_color.dart';
import '../../../widgets/header_bar/header_bar.dart';
import '../../api_email_msg/model/api_email_msg_model.dart';
import '../../api_email_sender/api_email_sender_service.dart';
import '../../api_email_sender/model/api_email_sender_model.dart';

class HomeScreenDecisionContainer extends StatelessWidget {
  ApiEmailSenderService _apiEmailSenderService;

  var _apiEmailMsgService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ConfigColor.greyOne),
      SafeArea(
          child: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Column(children: [
                HeaderBar(),
                Expanded(child:
                DecisionSdk(
                    isConnected: true,
                    isTestDone: false,
                    testDoneCallback : _testDone,
                    cards : _getCards()
                )
              ])))
    ])));
  }

  _testDone() {
  }

  Future<List<DecisionSdkAbstractCard>?> _getCards() async {
    List<ApiEmailSenderModel> senders = await _apiEmailSenderService
        .getUnsubscribed();
    Map<String, List<ApiEmailMsgModel>> messages =
    await _apiEmailMsgService.getBySenders(senders);

    for (ApiEmailSenderModel sender in senders) {
      List<ApiEmailMsgModel>? msgs = messages[sender.email!];
      if (msgs != null && msgs.isNotEmpty) {

      }
    }
  }
}
