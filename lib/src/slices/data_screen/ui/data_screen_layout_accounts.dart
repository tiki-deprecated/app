import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/link_account/link_account.dart';
import '../../api_auth_service/model/api_auth_service_account_model.dart';
import '../data_screen_service.dart';

class DecisionScreenLayoutAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataScreenService service = Provider.of<DataScreenService>(context);
    List<String> providers = service.getProvidersList();
    return Column(
        children: providers.map((provider) {
      List<ApiAuthServiceAccountModel> accounts =
          service.getAccountsByProvider(provider);
      ApiAuthServiceAccountModel? account =
          accounts.isEmpty ? null : accounts[0];
      return Container(
        margin: EdgeInsets.only(top: 2.h),
        child: LinkAccount(
          username: account?.username,
          type: provider,
          linkedIcon: "account-soon-" + provider,
          unlinkedIcon: provider + "-icon",
          onLink: () => service.controller.linkAccount(provider),
          onUnlink: () => account != null
              ? service.controller.removeAccount(account.accountId!)
              : null,
          onSee: () => account != null
              ? service.controller.openGmailCards(context, account.accountId!)
              : null,
        ),
      );
    }).toList());
  }
}
