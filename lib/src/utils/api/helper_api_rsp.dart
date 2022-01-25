/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'helper_api_rsp_message.dart';
import 'helper_api_rsp_page.dart';

class HelperApiRsp<T> {
  String? status;
  int? code;
  dynamic data;
  HelperApiRspPage? page;
  List<HelperApiRspMessage>? messages;

  HelperApiRsp({this.status, this.code, this.data, this.page, this.messages});

  //TODO from json -> make generic
  HelperApiRsp.fromJson(Map<String, dynamic>? json, T fromJson(Object? o)) {
    if (json != null) {
      this.status = json['status'] is String ? json['status'] : int.parse(json['status']);
      this.code = json['code'];
      this.data = fromJson(json['data']);
      this.page = HelperApiRspPage.fromJson(json['page']);
      List? msgList = json['messages'];
      if (msgList != null)
        this.messages =
            msgList.map((e) => HelperApiRspMessage.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'data': data, //TODO need interface for toJson()
        'page': page,
        'messages': messages
      };
}
