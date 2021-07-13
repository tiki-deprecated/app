/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'login_flow_service.dart';

class LoginFlowNavigator extends StatelessWidget {
  final GlobalKey? navigatorKey;

  LoginFlowNavigator({this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginFlowService>(context);
    return Navigator(
      key: navigatorKey,
      pages: service.getPages(),
      onPopPage: service.onPopPage,
    );
  }
}
