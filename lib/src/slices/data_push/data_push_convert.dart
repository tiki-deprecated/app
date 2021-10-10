/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:uuid/uuid.dart';

import '../api_email_msg/model/api_email_msg_model.dart';
import 'model/data_push_model.dart';

class DataPushConvert {
  static List<DataPushModel> message(ApiEmailMsgModel message) => [
        DataPushModel(
            fromType: "company",
            fromValue: message.sender?.company?.domain,
            toType: "content",
            toValue: "email",
            fingerprint: Uuid().v4()),
        DataPushModel(
            fromType: "content",
            fromValue: "email",
            toType: "action",
            toValue: "received",
            fingerprint: Uuid().v4()),
        DataPushModel(
            fromType: "action",
            fromValue: "received",
            toType: "day",
            toValue: message.receivedDate?.day.toString(),
            fingerprint: Uuid().v4()),
        DataPushModel(
            fromType: "day",
            fromValue: message.receivedDate?.day.toString(),
            toType: "month",
            toValue: message.receivedDate?.month.toString(),
            fingerprint: Uuid().v4()),
        DataPushModel(
            fromType: "month",
            fromValue: message.receivedDate?.month.toString(),
            toType: "year",
            toValue: message.receivedDate?.year.toString(),
            fingerprint: Uuid().v4()),
      ];
}
