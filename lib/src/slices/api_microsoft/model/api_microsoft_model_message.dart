/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import '../../../utils/json/json_utils.dart';
import 'api_microsoft_model_header.dart';
import 'api_microsoft_model_recipient.dart';

class ApiMicrosoftModelMessage extends JsonObject {
  String? etag;
  String? id;
  String? context;
  DateTime? receivedDateTime;
  List<ApiMicrosoftModelHeader>? internetMessageHeaders;
  ApiMicrosoftModelRecipient? from;
  List<ApiMicrosoftModelRecipient>? toRecipients;

  ApiMicrosoftModelMessage(
      {this.etag,
      this.id,
      this.context,
      this.receivedDateTime,
      this.internetMessageHeaders,
      this.from,
      this.toRecipients});

  ApiMicrosoftModelMessage.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      etag = json['@odata.etag'];
      id = json['id'];
      context = json['@odata.context'];
      receivedDateTime = DateTime.tryParse(json['receivedDateTime']);
      internetMessageHeaders = JsonUtils.listFromJson(
          json['internetMessageHeaders'],
          (json) => ApiMicrosoftModelHeader.fromJson(json));
      from = ApiMicrosoftModelRecipient.fromJson(json['from']);
      toRecipients = JsonUtils.listFromJson(json['toRecipients'],
          (json) => ApiMicrosoftModelRecipient.fromJson(json));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        '@odata.etag': etag,
        'id': id,
        '@odata.context': context,
        'receivedDateTime': receivedDateTime?.toIso8601String(),
        'internetMessageHeaders': JsonUtils.listToJson(internetMessageHeaders),
        'from': from?.toJson(),
        'toRecipients': JsonUtils.listToJson(toRecipients)
      };
}
