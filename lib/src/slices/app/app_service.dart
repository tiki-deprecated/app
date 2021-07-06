/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api/api_service.dart';
import 'package:app/src/slices/auth/auth_service.dart';
import 'package:app/src/slices/keys/model/keys_model.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_service.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
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
    await loadAuth();
    initDynamicLinks();
    getHome();
  }

  loadAuth() async {
    authService = AuthService();
    await authService.load();
    model.current = authService.current;
    model.user = authService.user;
  }

  getHome() {
    if (this.deepLink != null) {
      _handle(this.deepLink!);
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
      await loadAuth();
      final Uri? deepLink = dynamicLink?.link;
      if (deepLink != null) _handle(deepLink);
    }, onError: (OnLinkErrorException e) async {
      print(StackTrace.current);
      await Sentry.captureException(e, stackTrace: StackTrace.current);
    });
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    this.deepLink = data?.link;
  }

  _handle(Uri link) async {
    String dlPathBouncer = "/app/bouncer";
    this.home = AppModelRoutes.login;
    if (link.path == dlPathBouncer) {
      String? otp = link.queryParameters["otp"];
      if (otp != null && otp.isNotEmpty) {
        this.model.user = await authService.verifyOtp(otp);
        if (this.model.user?.address != null) {
          this.model.user!.isLoggedIn = true;
          updateUser(this.model.user!);
          this.home = AppModelRoutes.home;
        } else {
          this.home = KeysCreateScreenService(this);
        }
      }
    }
    this.reload();
  }

  saveUser(String email, AppModelUser user) async {
    if (user.address != null) {
      await SecureStorageRepositoryUser().save(
          email,
          AppModelUser(
              email: email,
              address: user.address,
              isLoggedIn: user.isLoggedIn));
    } else {
      await SecureStorageRepositoryUser()
          .save(email, AppModelUser(email: email, isLoggedIn: user.isLoggedIn));
    }
    this.reload();
  }

  Future<void> logout() async {
    this.home = AppModelRoutes.login;
    if (this.model.user == null) {
      this.model.user = AppModelUser(email: this.model.current!.email);
    }
    this.model.user!.isLoggedIn = false;
    updateUser(this.model.user!);
    this.reload();
  }

  void reload() {
    this.notifyListeners();
  }

  void saveReferralCode(String referral) {
    this.model.user!.code = referral;
    this.saveUser(this.model.user!.email!, this.model.user!);
  }

  void updateUser(AppModelUser user) {
    this.authService.user = user;
    this.model.user = user;
    this.saveUser(user.email!, user);
  }

  Future<void> keysGenerated(KeysModel keysWithAddress) async {
    ApiService apiService = ApiService();
    String referral =
        await apiService.getReferralCode(keysWithAddress.address!);
    AppModelUser user = AppModelUser(
      email: this.model.current!.email,
      address: keysWithAddress.address,
      isLoggedIn: true,
      code: referral,
    );
    this.home = KeysSaveScreenService();
    this.updateUser(user);
  }
}
