/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import '../../../utils/json/json_utils.dart';
import 'api_google_model_message.dart';

class ApiGoogleModelMessages extends JsonObject {
  List<ApiGoogleModelMessage>? messages;
  int? resultSizeEstimate;
  String? nextPageToken;

  ApiGoogleModelMessages(
      {this.messages, this.resultSizeEstimate, this.nextPageToken});

  ApiGoogleModelMessages.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      messages = JsonUtils.listFromJson(
          json['messages'], (json) => ApiGoogleModelMessage.fromJson(json));
      resultSizeEstimate = json['resultSizeEstimate'];
      nextPageToken = json['nextPageToken'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'messages': JsonUtils.listToJson(messages),
        'resultSizeEstimate': resultSizeEstimate,
        'nextPageToken': nextPageToken
      };
}
