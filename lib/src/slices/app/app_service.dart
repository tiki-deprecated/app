/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/auth/auth_service.dart';
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

  Uri? deepLink;

  AppService() {
    presenter = AppPresenter(this);
    model = AppModel();
    controller = AppController();
    loadHelperLogin();
    initDynamicLinks();
  }

  Widget getUI() {
    return presenter.render();
  }

  loadHelperLogin() async {
    authService = AuthService();
    await authService.load();
    model.current = authService.current;
    model.user = authService.user;
  }

  Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      "/": (BuildContext context) => getHome(),
      "/login": (BuildContext context) => AppModelRoutes.login,
      "/keys/new": (BuildContext context) => AppModelRoutes.keys,
    };
  }

  getHome() {
    if (this.deepLink != null) {
      _handle(this.deepLink!);
    } else if (authService.isReturning()) {
      if (authService.isLoggedIn()) {
        return AppModelRoutes.home;
      } else {
        return AppModelRoutes.login;
      }
    } else {
      return AppModelRoutes.intro;
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

  void _handle(Uri link) {
    const String _dlPathBouncer = "/app/bouncer";
    const String _dlPathBlockchain = "/app/blockchain";
    if (link.path == _dlPathBouncer) {
      _handleBouncer(link);
    } else if (link.path == _dlPathBlockchain) {
      _handleBlockchain(link);
    }
  }

  void _handleBouncer(Uri link) {
    // String? otp = link.queryParameters["otp"];
    // if (otp != null && otp.isNotEmpty) {
    //   BlocProvider.of<LoginOtpValidBloc>(ConfigNavigate.key.currentContext!)
    //       .add(LoginOtpValidChanged(otp));
    //   Navigator.of(ConfigNavigate.key.currentContext!).pushNamedAndRemoveUntil(
    //       ConfigNavigate.path.loginOtp, (route) => false);
    // }
  }

  void _handleBlockchain(Uri link) {
    // String? ref = link.queryParameters["ref"];
    // if (ref != null && ref.isNotEmpty) {
    //   BlocProvider.of<KeysReferralCubit>(context).updateReferer(ref);
    // }
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
