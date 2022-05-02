/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'tiki_api_model_rsp_message.dart';
import 'tiki_api_model_rsp_page.dart';

class TikiApiModelRsp<T> {
  String? status;
  int? code;
  dynamic data;
  TikiApiModelRspPage? page;
  List<TikiApiModelRspMessage>? messages;

  TikiApiModelRsp(
      {this.status, this.code, this.data, this.page, this.messages});

  TikiApiModelRsp.fromJson(Map<String, dynamic>? json,
      T Function(Map<String, dynamic>? json) fromJson) {
    if (json != null) {
      status = json['status'];
      code = json['code'];

      if (json['data'] != null) {
        data = json['data'] is List
            ? json['data'].map((e) => fromJson(e)).toList()
            : fromJson(json['data']);
      }

      if (json['page'] != null) {
        page = TikiApiModelRspPage().fromJson(json['page']);
      }

      if (json['messages'] != null) {
        messages = (json['messages'] as List)
            .map((e) => TikiApiModelRspMessage.fromJson(e))
            .toList();
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'data': data?.toJson(),
        'page': page?.toJson(),
        'messages': messages?.map((e) => e.toJson()).toList()
      };
}
