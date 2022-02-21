import 'package:flutter/material.dart';
import 'package:google_provider/google_provider.dart';
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
          Container(
              margin: EdgeInsets.only(top: 2.h),
              child: GoogleProvider().accountWidget(),
          )
    ]);
  }
}
