/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'login_flow_navigator.dart';
import 'login_flow_service.dart';

class LoginFlowDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> navigatorKey;
  final LoginFlowService service;

  LoginFlowDelegate(this.service) : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: service, child: LoginFlowNavigator(navigatorKey: navigatorKey));
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
