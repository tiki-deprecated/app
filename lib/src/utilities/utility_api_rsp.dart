/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utilities/utility_api_rsp_message.dart';
import 'package:app/src/utilities/utility_api_rsp_page.dart';

class UtilityAPIRsp<T> {
  String status;
  int code;
  dynamic data;
  UtilityAPIRspPage page;
  List<UtilityAPIRspMessage> messages;

  UtilityAPIRsp({this.status, this.code, this.data, this.page, this.messages});

  UtilityAPIRsp.fromJson(Map<String, dynamic> json, T fromJson(Object o)) {
    if (json != null) {
      this.status = json['status'];
      this.code = json['code'];
      this.data = fromJson(json['data']);
      this.page = UtilityAPIRspPage.fromJson(json['page']);
      List msgList = json['messages'];
      if (msgList != null)
        this.messages =
            msgList.map((e) => UtilityAPIRspMessage.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'data': data,
        'page': page,
        'messages': messages
      };
}
