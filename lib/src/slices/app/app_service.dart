/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/auth/auth_service.dart';
import 'package:app/src/slices/intro_screen/ui/intro_screen_layout.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_controller.dart';
import 'app_presenter.dart';
import 'model/app_model.dart';
import 'model/app_model_routes.dart';
import 'model/app_model_user.dart';
import 'repository/secure_storage_repository_user.dart';

class AppService extends ChangeNotifier {
  late AppPresenter presenter;
  late AppModel model;
  late AppController controller;
  late AuthService authService;

  var home;

  Uri? deepLink;

  AppService() {
    presenter = AppPresenter(this);
    model = AppModel();
    controller = AppController();
  }

  Widget getUI() {
    return presenter.render();
  }

  load() async {
    authService = AuthService();
    await authService.load();
    model.current = authService.current;
    model.user = authService.user;
    getHome();
    //initDynamicLinks();
  }

  getRoutes(BuildContext context) {
    this.model.routes =  {
      "/": (BuildContext context) => home.getUI(),
      "/login": (BuildContext context) => AppModelRoutes.login.getUI(),
      "/keys/new": (BuildContext context) => AppModelRoutes.keys.getUI(),
    };
  }

  getHome() {
    if (this.deepLink != null) {
      this.home = _handle(this.deepLink!);
    } else if (authService.isReturning()) {
      if (authService.isLoggedIn()) {
        this.home = AppModelRoutes.home;
      } else {
        this.home = AppModelRoutes.login;
      }
    } else {
      this.home = AppModelRoutes.intro;
    }
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          final Uri? deepLink = dynamicLink?.link;
          if (deepLink != null) _handle(deepLink);
        }, onError: (OnLinkErrorException e) async {
      await Sentry.captureException(e, stackTrace: StackTrace.current);
    });
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    this.deepLink = data?.link;
  }

  _handle(Uri link) {
    const String _dlPathBouncer = "/app/bouncer";
    const String _dlPathBlockchain = "/app/blockchain";
    if (link.path == _dlPathBouncer) {
      return _handleBouncer(link);
    } else if (link.path == _dlPathBlockchain) {
      return _handleBlockchain(link);
    }
    return AppModelRoutes.login;
  }

  _handleBouncer(Uri link) {
    // String? otp = link.queryParameters["otp"];
    // if (otp != null && otp.isNotEmpty) {
    //   BlocProvider.of<LoginOtpValidBloc>(ConfigNavigate.key.currentContext!)
    //       .add(LoginOtpValidChanged(otp));
    //   Navigator.of(ConfigNavigate.key.currentContext!).pushNamedAndRemoveUntil(
    //       ConfigNavigate.path.loginOtp, (route) => false);
    // }
    return AppModelRoutes.keys;
  }

  _handleBlockchain(Uri link) {
    // String? ref = link.queryParameters["ref"];
    // if (ref != null && ref.isNotEmpty) {
    //   BlocProvider.of<KeysReferralCubit>(context, listen:false).updateReferer(ref);
    // }
    return AppModelRoutes.home;
  }

  saveUser(String email, AppModelUser user) async {
    if (user.address != null) {
      await SecureStorageRepositoryUser().save(email,
          AppModelUser(email: email, address: user.address, isLoggedIn: true));
    } else {
      await SecureStorageRepositoryUser()
          .save(email, AppModelUser(email: email, isLoggedIn: false));
    }
    notifyListeners();
  }
}
