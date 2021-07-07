/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api/api_service.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/slices/user_referral/model/user_referral_model.dart';
import 'package:app/src/slices/user_referral/user_referral_controller.dart';
import 'package:app/src/slices/user_referral/user_referral_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UserReferralService extends ChangeNotifier {
  static const String _linkUrl = "https://mytiki.com/";

  late UserReferralPresenter presenter;
  late UserReferralController controller;
  late UserReferralModel model;

  UserReferralService() {
    this.presenter = UserReferralPresenter(this);
    this.controller = UserReferralController();
    this.model = UserReferralModel();
    getReferCount();
  }

  Widget getUI() {
    return this.presenter.render();
  }

  getCode(BuildContext context) {
    AppModelUser user = Provider.of<AppService>(context).model.user!;
    this.model.code = user.code ?? "";
    if (this.model.code.isEmpty) updateCode(context);
  }

  Future<void> copyLink() async {
    var code = this.model.code;
    await Clipboard.setData(new ClipboardData(text: _linkUrl + code));
  }

  getReferCount() async {
    var code = this.model.code;
    var apiService = ApiService();
    this.model.referCount = (await apiService.getReferCount(code))!;
    notifyListeners();
  }

  void updateCode(BuildContext context) async {
    var apiService = ApiService();
    AppService appService = Provider.of<AppService>(context);
    AppModelUser user = appService.model.user!;
    apiService.getReferralCode(user.address!).then((referral) async {
      if (referral != null) {
        this.model.code = referral;
        user.code = this.model.code;
        await appService.updateUser(user);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      // SEND TO SENTRY
      Provider.of<TikiScreenService>(context, listen: false)
          .removeGoogleAccount();
      appService.logout();
    });
  }
}
