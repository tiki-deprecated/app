/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../json/json_object.dart';
import '../json/json_utils.dart';
import 'api_tiki_rsp_message.dart';
import 'api_tiki_rsp_page.dart';

class ApiTikiRsp<T extends JsonObject> extends JsonObject {
  String? status;
  int? code;
  dynamic data;
  ApiTikiRspPage? page;
  List<ApiTikiRspMessage>? messages;

  ApiTikiRsp({this.status, this.code, this.data, this.page, this.messages});

  ApiTikiRsp.fromJson(
      Map<String, dynamic>? json, T fromJson(Map<String, dynamic>? json)) {
    if (json != null) {
      status = json['status'];
      code = json['code'];

      if (json['data'] != null) {
        data = json['data'] is List
            ? JsonUtils.listFromJson(json['data'], (json) => fromJson)
            : fromJson(json);
      }

      if (json['page'] != null) page = ApiTikiRspPage().fromJson(json['page']);

      this.messages = JsonUtils.listFromJson(
          json['messages'], (json) => ApiTikiRspMessage().fromJson(json));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'data': data?.toJson(),
        'page': page?.toJson(),
        'messages': JsonUtils.listToJson(messages)
      };
}
