import 'package:flutter/material.dart';
import 'package:google_provider/google_provider.dart';
import 'package:microsoft_provider/microsoft_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../api_oauth/model/api_oauth_model_account.dart';
import '../data_screen_service.dart';

class DecisionScreenLayoutAccounts extends StatelessWidget {
  const DecisionScreenLayoutAccounts({Key? key}) : super(key: key);

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
                    ).accountWidget()
                  : GoogleProvider(
                      onLink: (model) {
                        ApiOAuthModelAccount account =
                            service.controller.saveAccount(model, 'google');
                        service.fetchInbox(account);
                      },
                      onUnlink: (email) => account != null
                          ? service.controller.removeAccount(email!, 'google')
                          : null,
                    ).accountWidget()),
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
                    ).accountWidget()
                  : MicrosoftProvider(
                      onLink: (model) =>
                          service.controller.saveAccount(model, 'microsoft'),
                      onUnlink: (email) =>
                          service.controller.removeAccount(email!, 'microsoft'),
                    ).accountWidget()),
    ]);
  }
}
