/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_app_data/api_app_data_key.dart';
import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
import 'package:flutter/widgets.dart';

import '../data_screen/data_screen_service.dart';
import 'google_oauth_modal_controller.dart';
import 'google_oauth_modal_presenter.dart';

class GoogleOauthModalService extends ChangeNotifier {
  late final GoogleOauthModalController controller;
  late final GoogleOauthModalPresenter presenter;
  DataScreenService _dataScreenService;
  ApiAppDataService _apiAppDataService;

  GoogleOauthModalService(
      {required ApiAppDataService apiAppDataService,
      required DataScreenService dataScreenService})
      : this._apiAppDataService = apiAppDataService,
        this._dataScreenService = dataScreenService {
    this.controller = GoogleOauthModalController(this);
    this.presenter = GoogleOauthModalPresenter(this);
  }

  Future<void> finished() async {
    _apiAppDataService.save(ApiAppDataKey.googleOauthModalComplete, "true");
    _dataScreenService.addGoogleAccount();
  }
}
