import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/link_account/link_account.dart';
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
              child: LinkAccount(
                username: account?.email,
                type: 'Google',
                linkedIcon: "account-soon-google",
                unlinkedIcon: "google-icon",
                onLink: () => service.controller.linkAccount('google'),
                onUnlink: () =>
                    account != null ? service.controller.removeAccount() : null,
                onSee: () => account != null
                    ? service.controller
                        .openGmailCards(context, account.accountId!)
                    : null,
              )),
      account != null && account.provider != "microsoft"
          ? Container()
          : Container(
              margin: EdgeInsets.only(top: 2.h),
              child: LinkAccount(
                username: account?.email,
                type: 'Microsoft',
                linkedIcon: "account-soon-outlook",
                unlinkedIcon: "windows-logo",
                onLink: () => service.controller.linkAccount('microsoft'),
                onUnlink: () =>
                    account != null ? service.controller.removeAccount() : null,
                onSee: () => account != null
                    ? service.controller
                        .openGmailCards(context, account.accountId!)
                    : null,
              ))
    ]);
  }
}
