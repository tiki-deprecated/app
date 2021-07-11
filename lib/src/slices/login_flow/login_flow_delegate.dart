/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/login_flow/model/login_flow_model_path.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'login_flow_navigator.dart';
import 'login_flow_service.dart';

class LoginFlowDelegate extends RouterDelegate<LoginFlowModelPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<LoginFlowModelPath> {
  final GlobalKey<NavigatorState> navigatorKey;
  final LoginFlowService service;

  LoginFlowDelegate(this.service) : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: service, child: LoginFlowNavigator(navigatorKey: navigatorKey));
  }

  @override
  Future<void> setNewRoutePath(LoginFlowModelPath configuration) async {}
}
