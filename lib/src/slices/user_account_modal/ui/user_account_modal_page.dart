import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../user_account_modal_service.dart';
import 'user_account_modal_layout.dart';

class UserAccountModalPage extends Page {

  final UserAccountModalService service;

  UserAccountModalPage(this.service)
      : super(key: ValueKey('UserAccountModalPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) =>
            ChangeNotifierProvider.value(
                value: service, child: UserAccountModalLayout())
    );
  }
}
