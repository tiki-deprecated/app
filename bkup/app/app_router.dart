/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:app/src/slices/app/model/app_model_routes.dart';
import 'package:flutter/cupertino.dart';

import 'app_service.dart';

class AppRouter extends RouterDelegate<AppService>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final AppService appService;
  final GlobalKey<NavigatorState> _navigatorKey;

  AppRouter(this.appService) : _navigatorKey = GlobalKey() {
    appService.addListener(() {
      notifyListeners();
    });
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        onPopPage: (route, result) {
          if (route.didPop(result)) return true;
          return false;
        },
        pages: [
          appService.model.isLoggedIn
              ? AppModelRoutes.home.getUI()
              : AppModelRoutes.login.getUI(),
        ]);
  }

  @override
  Future<void> setNewRoutePath(AppService appService) async {
    return;
  }
}
