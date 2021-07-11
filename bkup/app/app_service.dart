/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';

import 'package:app/src/slices/api/api_service.dart';
import 'package:app/src/slices/auth/auth_service.dart';
import 'package:app/src/slices/keys/model/keys_model.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_controller.dart';
import 'app_presenter.dart';
import 'app_router.dart';
import 'model/app_model.dart';
import 'model/app_model_user.dart';
import 'repository/secure_storage_repository_user.dart';

class AppService extends ChangeNotifier {
  late AppPresenter presenter;
  late AppRouter router;
  late AppModel model;
  late AppController controller;
  late AuthService authService;

  Uri? deepLink;

  get isReturning => model.current?.email != null;

  AppService() {
    presenter = AppPresenter(this);
    model = AppModel();
    controller = AppController();
    router = AppRouter(this);
  }

  Widget getUI() {
    return presenter.render();
  }

  Future<void> load() async {
    await loadAuth();
    await initDynamicLinks();
  }

  Future<void> loadAuth() async {
    authService = AuthService();
    await authService.load();
    model.current = authService.current;
    model.user = authService.user;
    model.user?.keys = authService.keys;
    model.user?.token = authService.token;
  }

  Future<void> saveUser(String email, AppModelUser user) async {
    await SecureStorageRepositoryUser().save(
        email,
        AppModelUser(
            email: email,
            address: user.address,
            isLoggedIn: user.isLoggedIn,
            code: user.code));
    notifyListeners();
  }

  Future<void> logout() async {
    if (this.model.user == null) {
      this.model.user = AppModelUser(email: this.model.current!.email);
    }
    this.model.user!.isLoggedIn = false;
    await updateUser(this.model.user!);
    notifyListeners();
  }

  void saveReferralCode(String referral) {
    this.model.user!.code = referral;
    this.saveUser(this.model.user!.email!, this.model.user!);
  }

  Future<void> updateUser(AppModelUser user) async {
    this.authService.user = user;
    this.model.user = user;
    this.model.user?.keys = authService.keys;
    this.model.user?.token = authService.token;
    await this.saveUser(user.email!, user);
  }

  Future<void> keysGenerated(KeysModel keysWithAddress) async {
    ApiService apiService = ApiService();
    String? referral =
        await apiService.getReferralCode(keysWithAddress.address!);
    AppModelUser user = AppModelUser(
      email: this.model.current!.email,
      address: keysWithAddress.address,
      isLoggedIn: true,
      code: referral,
    );
    await this.updateUser(user);
  }

  Future<bool> requestOtp(String email) async {
    bool result = await authService.requestOtp(email);
    if (result) {
      model.current = authService.current;
    }
    return result;
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      await loadAuth();
      final Uri? deepLink = dynamicLink?.link;
      if (deepLink != null) await _handle(deepLink);
    }, onError: (OnLinkErrorException e) async {
      await Sentry.captureException(e, stackTrace: StackTrace.current);
    });
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    this.deepLink = data?.link;
  }

  Future<void> _handle(Uri link) async {
    final String dlPathBouncer = "/app/bouncer";
    if (link.path == dlPathBouncer) {
      String? otp = link.queryParameters["otp"];
      if (otp != null && otp.isNotEmpty) {
        var user = await authService.verifyOtp(otp);
        if (user != null) {
          if (user.address != null) user.isLoggedIn = true;
          await updateUser(user);
        }
      }
    }
    notifyListeners();
  }

  void goToHome() {
    if (model.isLoggedIn) notifyListeners();
  }
}
