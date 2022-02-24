import 'package:flutter/material.dart';
import 'package:google_provider/google_provider.dart';
import 'package:microsoft_provider/microsoft_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../api_oauth/model/api_oauth_model_account.dart';
import '../data_screen_service.dart';

class DecisionScreenLayoutAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataScreenService service = Provider.of<DataScreenService>(context);
    ApiOAuthModelAccount? account = service.account;
    return Column(children: [
      account != null && account.provider != "google"
          ? Container()
          : Container(
              margin: EdgeInsets.only(top: 2.h),
              child: account != null
                  ? GoogleProvider.loggedIn(
                      token: account.accessToken,
                      refreshToken: account.refreshToken,
                      email: account.email,
                      displayName: account.displayName,
                      onLink: (model) =>
                          service.controller.saveAccount(model, 'google'),
                      onUnlink: (email) =>
                          service.controller.removeAccount(email!, 'google'),
                      onSee: (cardsData) => service.controller
                          .openGmailCards(context, 0)).accountWidget()
                  : GoogleProvider(
                      onLink: (model) =>
                          service.controller.saveAccount(model, 'google'),
                      onUnlink: (email) => account != null
                          ? service.controller.removeAccount(email!, 'google')
                          : null,
                      onSee: (cardsData) => service.controller
                          .openGmailCards(context, 0)).accountWidget()),
      account != null && account.provider != "microsoft"
          ? Container()
          : Container(
              margin: EdgeInsets.only(top: 2.h),
              child: account != null
                  ? MicrosoftProvider.loggedIn(
                      token: account.accessToken,
                      refreshToken: account.refreshToken,
                      email: account.email,
                      displayName: account.displayName,
                      onLink: (model) =>
                          service.controller.saveAccount(model, 'microsoft'),
                      onUnlink: (email) =>
                          service.controller.removeAccount(email!, 'microsoft'),
                      onSee: (cardsData) => service.controller
                          .openCards(context, cardsData)).accountWidget()
                  : MicrosoftProvider(
                      onLink: (model) =>
                          service.controller.saveAccount(model, 'microsoft'),
                      onUnlink: (email) =>
                          service.controller.removeAccount(email!, 'microsoft'),
                      onSee: (cardsData) => service.controller
                          .openCards(context, cardsData)).accountWidget()),
    ]);
  }
}
