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
    List<ApiAuthServiceAccountModel> accounts = service.getAccountList();
    return Column(
        children: accounts
            .map((account) => Container(
                  margin: EdgeInsets.only(top: 2.h),
                  child: LinkAccount(
                    username: account.email,
                    type: account.provider!,
                    linkedIcon: "account-soon-" + account.provider!,
                    unlinkedIcon: account.provider! + "-icon",
                    onLink: () =>
                        service.controller.linkAccount(account.provider!),
                    onUnlink: () =>
                        service.controller.removeAccount(account.accountId!),
                    onSee: () => service.controller.openGmailCards(context),
                  ),
                ))
            .toList());
  }
}
