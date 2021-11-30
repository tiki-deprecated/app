/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../api_email_msg/model/api_email_msg_model.dart';

class DataFetchModelPage {
  List<ApiEmailMsgModel>? data;
  String? next;

  DataFetchModelPage({this.data, this.next});
}
