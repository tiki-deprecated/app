/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api/api_service.dart';
import 'package:app/src/slices/auth/auth_service.dart';
import 'package:app/src/slices/keys/model/keys_model.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
import 'package:flutter/material.dart';

import 'app_controller.dart';
import 'app_presenter.dart';
import 'app_router.dart';
import 'model/app_model.dart';
import 'model/app_model_routes.dart';
import 'model/app_model_user.dart';
import 'repository/secure_storage_repository_user.dart';

class AppService extends ChangeNotifier {
  late AppPresenter presenter;
  late AppRouter router;
  late AppModel model;
  late AppController controller;
  late AuthService authService;

  var home;

  Uri? deepLink;

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
    authService = AuthService();
    await authService.load();
    model.current = authService.current;
    model.user = authService.user;
  }

  Future<void> saveUser(String email, AppModelUser user) async {
    await SecureStorageRepositoryUser().save(
        email,
        AppModelUser(
            email: email,
            address: user.address,
            isLoggedIn: user.isLoggedIn,
            code: user.code));
    this.reload();
  }

  Future<void> logout() async {
    this.home = AppModelRoutes.login;
    if (this.model.user == null) {
      this.model.user = AppModelUser(email: this.model.current!.email);
    }
    this.model.user!.isLoggedIn = false;
    await updateUser(this.model.user!);
    this.reload();
  }

  void reload() {
    this.notifyListeners();
  }

  void saveReferralCode(String referral) {
    this.model.user!.code = referral;
    this.saveUser(this.model.user!.email!, this.model.user!);
  }

  Future<void> updateUser(AppModelUser user) async {
    this.authService.user = user;
    this.model.user = user;
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
    this.home = KeysSaveScreenService();
    await this.updateUser(user);
  }
}
