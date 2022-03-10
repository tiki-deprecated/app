/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../api_oauth/model/api_oauth_model_account.dart';
import 'data_fetch_model_api.dart';

class DataFetchModelLast {
  int? fetchId;
  ApiOAuthModelAccount? account;
  DataFetchModelApi? api;
  DateTime? fetched;

  DataFetchModelLast({this.fetchId, this.account, this.api, this.fetched});

  DataFetchModelLast.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      fetchId = json['fetch_id'];
      if (json['account'] != null) {
        account = ApiOAuthModelAccount.fromJson(json['account']);
      }
      if (json['api_enum'] != null) {
        api = DataFetchModelApi.from(json['api_enum']);
      }
      if (json['fetched_epoch'] != null) {
        fetched = DateTime.fromMillisecondsSinceEpoch(json['fetched_epoch']);
      }
    }
  }
}
