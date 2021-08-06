/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_google/api_google_service.dart';
import 'model/data_bkg_model.dart';

class DataBkgService {
  final DataBkgModel model = DataBkgModel();
  final ApiGoogleService _apiGoogleService;

  DataBkgService(this._apiGoogleService);

  Future<void> fetchEmail() async {
    List<ApiEmailMsgModel> msgs =
        await _apiGoogleService.gmailFetch(unsubscribeOnly: true);
    print(msgs.length);
  }
}
