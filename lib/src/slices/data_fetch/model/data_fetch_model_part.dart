/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../utils/json/json_object.dart';
import '../../api_oauth/model/api_oauth_model_account.dart';
import 'data_fetch_model_api.dart';

class DataFetchModelPart<T extends JsonObject> {
  int? partId;
  String? extId;
  ApiOAuthModelAccount? account;
  DataFetchModelApi? api;
  T? obj;
  DateTime? created;
  DateTime? modified;

  DataFetchModelPart(
      {this.partId,
      this.extId,
      this.account,
      this.api,
      this.obj,
      this.created,
      this.modified});

  DataFetchModelPart.fromJson(
      Map<String, dynamic>? json, T fromJson(Map<String, dynamic>? json)) {
    if (json != null) {
      partId = json['part_id'];
      extId = json['ext_id'];
      if (json['account'] != null)
        account = ApiOAuthModelAccount.fromJson(json['account']);
      if (json['api_enum'] != null)
        api = DataFetchModelApi.from(json['api_enum']);
      if (json['obj_json'] != null)
        obj = fromJson(jsonDecode(json['obj_json']));
      if (json['modified_epoch'] != null)
        modified = DateTime.fromMillisecondsSinceEpoch(json['modified_epoch']);
      if (json['created_epoch'] != null)
        created = DateTime.fromMillisecondsSinceEpoch(json['created_epoch']);
    }
  }
}
